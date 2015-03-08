angular.module('app').controller('ExportController', function($scope, $http, $window) {
  $scope.comps = [];
  $scope.framesets = [];
  $scope.selectedFrameset = null;
  $scope.selectedComp = null;
  $scope.showFramesets = false;

  $scope.offset = 0;
  $scope.dragging = false;
  $scope.dragStart = [0,0];

  $http.get('/framesets').then(function(response) {
    $scope.framesets = response.data.framesets;
    if ($scope.framesets.length > 0) $scope.selectFrameset($scope.framesets[0]);
  });

  $http.get(document.location.href).then(function(response) {
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

  $scope.startDrag = function($event) {
    if ($event.button == 0) {
      $event.preventDefault();
      $scope.dragging = true;
      $scope.dragStart = [$event.pageX,$event.pageY];
      $scope.dragEnd = [$event.pageX,$event.pageY];
    }
  }

  $scope.drag = function($event) {
    if ($scope.dragging) {
      $event.preventDefault();
      $scope.dragEnd = [$event.pageX,$event.pageY];
    }
  }

  $scope.stopDrag = function($event) {
    if ($scope.dragging) {
      $event.preventDefault();
      $scope.dragging = false;
      $scope.offset = Math.max(0, $scope.offset + ($scope.dragStart[1] - $scope.dragEnd[1]));
      $scope.dragStart = [0,0];
      $scope.dragEnd = [0,0];
    }
  }

  $scope.compWrapperStyle = function() {
    if (!$scope.selectedFrame || !$scope.frameRatio) return {};

    return {
      left: Math.floor($scope.selectedFrame.images.preview[0].left * $scope.frameRatio),
      top: Math.floor($scope.selectedFrame.images.preview[0].top * $scope.frameRatio),
      height: Math.round($scope.selectedFrame.images.preview[0].height * $scope.frameRatio) + 1,
      width: Math.round($scope.selectedFrame.images.preview[0].width * $scope.frameRatio) + 1
    };
  }

  $scope.compStyle = function() {
    var dragOffset = 0;
    if ($scope.dragging) {
      dragOffset = Math.max(0, $scope.dragStart[1] - $scope.dragEnd[1]);
    }

    return {
      position: 'relative',
      top: ($scope.offset + dragOffset) * -1
    };
  }

  $scope.toggleFramesetDropdown = function($event) {
    $event.stopPropagation();
    $scope.showFramesets = !$scope.showFramesets;
  }
  $(window).on('click', function() { $scope.showFramesets = false; $scope.$apply(); });

});
