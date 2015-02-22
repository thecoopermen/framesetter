angular.module('app').controller('UploadController', function($scope, $element, $http) {
  $scope.queue = []

  $scope.selectFiles = function($event) {
    $event.preventDefault();
    $element.find('input[type=file]').trigger('click');
  }

  $scope.remove = function($event, file) {
    if (file.$destroy) file.$destroy();
    file.hidden = true
    $http.delete('/comps/' + file.result.id);
  }

  $scope.$on('fileuploadadd', function($scope, file) {
    file.submit();
  });

  $scope.$on('fileuploaddone', function($scope, upload) {
    upload.files[0].result = upload.result
  });
});
