//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require turbolinks
//= require angular
//
//= require load-image.all.min
//= require jquery.iframe-transport
//= require jquery.fileupload
//= require jquery.fileupload-process
//= require jquery.fileupload-image
//= require jquery.fileupload-angular
//
//= require_self
//= require_tree ./controllers

angular.module('app', ['blueimp.fileupload']).config(function($httpProvider) {
  $httpProvider.defaults.xsrfHeaderName = 'X-CSRF-Token';
  $httpProvider.defaults.headers.common['Accept'] = 'application/json';
});
