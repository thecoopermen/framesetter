angular.module('app').controller('UploadController', function($scope, $element, $http, $filter) {
  $scope.queue = []

  $scope.selectFiles = function($event) {
    $event.preventDefault();
    $element.find('input[type=file]').trigger('click');
  }

  $scope.remove = function($event, file) {
    if (file.$destroy) file.$destroy();
    if (file.result) $http.delete('/comps/' + file.result.id);
    file.hidden = true
  }

  $scope.readyToExport = function() {
    if ($scope.queue.length == 0) return false;

    var incomplete = $filter('filter')($scope.queue, function(file, i) {
      return file.hidden || file.$state() != "resolved"
    });
    return incomplete.length == 0;
  }

  $scope.guardExport = function($event) {
    if (!$scope.readyToExport()) $event.preventDefault();
  }

  $scope.$on('fileuploadadd', function($scope, file) {
    file.submit();
  });

  $scope.$on('fileuploaddone', function($scope, upload) {
    upload.files[0].result = upload.result
  });
});
