angular.module('app').controller('UploadController', function($scope, $element) {
  $scope.queue = []

  $scope.selectFiles = function($event) {
    $event.preventDefault();
    $element.find('input[type=file]').trigger('click');
  };

  $scope.$on('fileuploadadd', function($scope, file) {
    file.submit();
  });
});
