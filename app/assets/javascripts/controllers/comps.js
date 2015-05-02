angular.module('app').controller('CompsController', function($scope, $element, $http, $filter) {
  $scope.queue = []
  $scope.comps = []

  $http.get('/comps.json').then(function(response) {
    $scope.comps = response.data.comps;
  });

  $scope.selectFiles = function($event) {
    $event.preventDefault();
    $element.find('input[type=file]').trigger('click');
  }

  $scope.remove = function($event, comp) {
    $event.stopPropagation();
    $scope.comps.splice($scope.comps.indexOf(comp), 1);
    $http.delete('/comps/' + comp.id);
  }

  $scope.selectedComps = function() {
    return $scope.comps.filter(function(comp) {
      return comp.selected;
    });
  }

  $scope.readyToExport = function() {
    return !$scope.inProgress() && $scope.selectedComps().length > 0;
  }

  $scope.inProgress = function() {
    var incomplete = $filter('filter')($scope.queue, function(file, i) {
      return file.$state() != "resolved"
    });
    return incomplete.length > 0;
  }

  $scope.export = function($event) {
    $event.preventDefault();
    if (!$scope.readyToExport()) return;

    var comps_attributes = $scope.selectedComps().map(function(comp) {
      return { comp_id: comp.id };
    });
    $http.post('/exports', {export: {export_comps_attributes: comps_attributes}}).then(function(response) {
      document.location.href = '/exports/' + response.data.id;
    });
  }

  $scope.$on('fileuploadadd', function($uploadScope, file) {
    var reader = new FileReader();
    reader.onloadend = function() {
      var comp = {uploading: true, name: file.files[0].name.replace(/\..*$/, ''), image: {thumbnail: reader.result}}
      file.files[0].comp = comp;
      $scope.comps.unshift(comp);
    }
    file.submit();
    reader.readAsDataURL(file.files[0]);
  });

  $scope.$on('fileuploaddone', function($scope, upload) {
    upload.files[0].comp.uploading = false;
    upload.files[0].comp.id = upload.result.id;
    upload.files[0].result = upload.result;
  });
});
