angular.module('app').controller('ExportController', function($scope, $http, $window) {
  $scope.comps = [];
  $scope.framesets = [];
  $scope.selectedFrameset = null;
  $scope.selectedComp = null;
  $scope.showFramesets = false;

  $http.get('/framesets').then(function(response) {
    $scope.framesets = response.data.framesets;
    if ($scope.framesets.length > 0) $scope.selectFrameset($scope.framesets[0]);
  });

  $http.get('/comps').then(function(response) {
    $scope.comps = response.data.comps;
    if ($scope.comps.length > 0) $scope.selectComp($scope.comps[0]);
  });

  $scope.selectComp = function(comp) {
    $scope.selectedComp = comp;
  }

  $scope.selectFrameset = function(frameset) {
    if (frameset == $scope.selectedFrameset) return;
    $scope.selectedFrameset = frameset;
    if (frameset.frames.length > 0) $scope.selectFrame($scope.selectedFrameset.frames[0]);
  }

  $scope.selectFrame = function(frame) {
    $scope.selectedFrame = frame;
  }

  $scope.updateFrameRatio = function($event) {
    var img = $($event.target),
        frame = new Image();

    frame.src = img.attr('src');
    $scope.frameRatio = 524 / frame.width;
  }

  $scope.compWrapperStyle = function() {
    if (!$scope.selectedFrame || !$scope.frameRatio) return {};

    return {
      left: Math.floor($scope.selectedFrame.left * $scope.frameRatio),
      top: Math.floor($scope.selectedFrame.top * $scope.frameRatio),
      height: Math.round($scope.selectedFrame.height * $scope.frameRatio) + 1,
      width: Math.round($scope.selectedFrame.width * $scope.frameRatio) + 1
    };
  }

  $scope.toggleFramesetDropdown = function($event) {
    $event.stopPropagation();
    $scope.showFramesets = !$scope.showFramesets;
  }
  $(window).on('click', function() { $scope.showFramesets = false; $scope.$apply(); });
});
