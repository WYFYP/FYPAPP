angular.module('Server', []).factory('Server', function($http,$state,$ionicPopup) {
  var apiHost = "http://127.0.0.1:8888";
  return {
      "host":apiHost,
      "fetch":function (path,data,callback){
          var request = {};
          request["url"] = apiHost+ path;
          request["method"]= data?"POST":"GET";
          if(typeof data != "function"){
              request["data"] = data;
          }else{
              callback = data;
          }
          $http(request)
          .success(function(res){
              if(res["code"] == "1001"){
                  $state.go('login');
                  debugger;
              }
              if(res["code"] != 0 ){
                  var alertPopup = $ionicPopup.alert({
                      title: 'Error',
                      template: res["msg"] 
                  });
              }
              callback(res)   
          }).error(() => {
              var alertPopup = $ionicPopup.alert({
                      title: 'Net Error',
                      template:"Network Error!"
                  });
          })
      },
  }
});
