angular.module('app').controller('CompsController', function($scope, $element, $http, $filter) {
  $scope.queue = []
  $scope.comps = []

  $http.get('/comps').then(function(response) {
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

  $scope.readyToExport = function() {
    if ($scope.queue.length == 0) return false;
    return !$scope.inProgress();
  }

  $scope.inProgress = function() {
    var incomplete = $filter('filter')($scope.queue, function(file, i) {
      return file.$state() != "resolved"
    });
    return incomplete.length > 0;
  }

  $scope.guardExport = function($event) {
    if (!$scope.readyToExport()) $event.preventDefault();
  }

  $scope.$on('fileuploadadd', function($uploadScope, file) {
    var reader = new FileReader();
    reader.onloadend = function() {
      var comp = {uploading: true, name: file.files[0].name, image: {thumbnail: reader.result}}
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
