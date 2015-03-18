angular.module('app').controller('ExportController', function($scope, $http, $window) {
  $scope.comps = [];
  $scope.framesets = [];
  $scope.selectedFrameset = null;
  $scope.selectedComp = null;
  $scope.showFramesets = false;
  $scope.scaledHeight = null;
  $scope.rotation = 0;

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

  function updateScaledHeight() {
    $scope.scaledHeight = null;
    if ($scope.selectedComp && $scope.selectedFrame) {
      var comp = new Image();
      comp.src = $scope.selectedComp.image.original;

      comp.onload = function() {
        $scope.scaledHeight = comp.height * ($scope.selectedFrame.images.preview[$scope.rotation].width / comp.width);
      };
    }
  }

  $scope.selectComp = function(comp) {
    $scope.selectedComp = comp;
    updateScaledHeight();
  }

  $scope.rotate = function($event) {
    $event.preventDefault();
    $scope.rotation = ($scope.rotation == 270) ? 0 : $scope.rotation + 90;
  }

  $scope.selectFrameset = function(frameset) {
    if (frameset == $scope.selectedFrameset) return;
    $scope.selectedFrameset = frameset;
    if (frameset.frames.length > 0) $scope.selectFrame($scope.selectedFrameset.frames[$scope.rotation]);
  }

  $scope.selectFrame = function(frame) {
    $scope.selectedFrame = frame;
    updateScaledHeight();
  }

  $scope.startDrag = function($event) {
    if ($event.button == 0) {
      $event.preventDefault();
      $scope.dragging = true;
      $scope.dragStart = $scope.dragEnd = [$event.pageX,$event.pageY];
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
    if (!$scope.selectedFrame) return {};

    return {
      left: $scope.selectedFrame.images.preview[$scope.rotation].left,
      top: $scope.selectedFrame.images.preview[$scope.rotation].top,
      height: $scope.selectedFrame.images.preview[$scope.rotation].height,
      width: $scope.selectedFrame.images.preview[$scope.rotation].width
    };
  }

  $scope.compStyle = function() {
    if (!$scope.scaledHeight) return { position: 'relative', top: 0 };

    var dragOffset = 0;
    if ($scope.dragging) {
      dragOffset = $scope.dragStart[1] - $scope.dragEnd[1];
    }

    var maxScroll = ($scope.scaledHeight - $scope.selectedFrame.images.preview[$scope.rotation].height) * -1,
        newTop = ($scope.offset + dragOffset) * -1;

    return {
      position: 'relative',
      top: Math.max(maxScroll, Math.min(0, newTop))
    };
  }

  $scope.toggleFramesetDropdown = function($event) {
    $event.stopPropagation();
    $scope.showFramesets = !$scope.showFramesets;
  }
  $(window).on('click', function() { $scope.showFramesets = false; $scope.$apply(); });

});
