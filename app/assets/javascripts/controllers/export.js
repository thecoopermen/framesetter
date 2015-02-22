angular.module('app').controller('ExportController', function($scope, $http) {
  $scope.framesets = [];
  $scope.frameset = null;

  $http.get('/framesets').then(function(response) {
    $scope.framesets = response.data.framesets;
    if ($scope.framesets.length > 0) $scope.selectFrameset($scope.framesets[0]);
  });

  $scope.selectFrameset = function(frameset) {
    if ($scope.frameset) $scope.frameset.selected = false;
    $scope.frameset = frameset;
    $scope.frameset.selected = true;
  }
});
