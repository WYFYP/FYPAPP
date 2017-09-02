// Ionic Starter App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
// 'starter.services' is found in services.js
// 'starter.controllers' is found in controllers.js


var app = angular.module('Eventor', ['ionic', 'Server', 'starter.controllers'])

  .run(function ($ionicPlatform) {
    $ionicPlatform.ready(function () {
      // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
      // for form inputs)
      if (window.cordova && window.cordova.plugins && window.cordova.plugins.Keyboard) {
        cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
        cordova.plugins.Keyboard.disableScroll(true);

      }
      if (window.StatusBar) {
        // org.apache.cordova.statusbar required
        StatusBar.styleDefault();
      }
    });
  })

  .config(function ($stateProvider, $urlRouterProvider) {

    $stateProvider
      .state('login', {
        url: '/login',
        templateUrl: "templates/login.html",
        controller: 'LoginCtrl'
      })

      .state('regist', {
        url: '/regist',
        templateUrl: "templates/regist.html",
        controller: 'LoginCtrl'
      })

      .state('tabs', {
        url: "/tab",
        abstract: true,
        templateUrl: "templates/tabs.html"
      })

      .state('tabs.home', {
        url: "/home",
        views: {
          'home-tab': {
            templateUrl: "templates/home.html",
            controller: 'HomeCtrl'
          }
        }
      })

      .state('tabs.discover', {
        url: "/discover",
        views: {
          'discover-tab': {
            templateUrl: "templates/discover.html",
            controller: 'DiscoverCtrl'
          }
        }
      })

      .state('tabs.chat', {
        url: "/chat",
        views: {
          'chat-tab': {
            templateUrl: "templates/chat.html",
            controller: 'ChatListCtrl'
          }
        }
      })

      .state('tabs.chatting', {
        url: "/chat/:eid",
        views: {
          'chat-tab': {
            templateUrl: "templates/chatting.html",
            controller: 'ChattingCtrl'
          }
        }
      })

      .state('tabs.create', {
        url: "/create",
        views: {
          'create-tab': {
            templateUrl: "templates/create.html",
            controller: 'createCtrl'
          }
        }
      })



      //重复定义 event 详情页路由
      .state('tabs.homeevent', {
        url: '/home/event/:eid',
        views: {
          'home-tab': {
            templateUrl: "templates/event.html",
            controller: 'EventCtrl'
          },
        }
      })
      .state('tabs.discoverevent', {
        url: '/discover/event/:eid',
        views: {
          'discover-tab': {
            templateUrl: "templates/event.html",
            controller: 'EventCtrl'
          },
        }
      })

      .state('tabs.ucenterevent', {
        url: '/ucenter/event/:eid',
        views: {
          'my-tab': {
            templateUrl: "templates/event.html",
            controller: 'EventCtrl'
          },
        }
      })


      //个人中心
      .state('tabs.ucenter', {
        url: "/ucenter",
        views: {
          'my-tab': {
            templateUrl: "templates/ucenter.html",
            controller: 'UcenterCtrl'
          }
        }
      })
      // 我的个人页面
      .state('tabs.myinfo', {
        url: "/user/:type",
        views: {
          'my-tab': {
            templateUrl: "templates/userinfo.html",
            controller: 'UserInfoCtrl'
          }
        }
      })
      // 其他人个人页面
      .state('tabs.userinfo', {
        url: "/user/:type/:uid",
        views: {
          'my-tab': {
            templateUrl: "templates/userinfo.html",
            controller: 'UserInfoCtrl'
          }
        }
      })
      // 我的关注
      .state('tabs.following', {
        url: "/following",
        views: {
          'my-tab': {
            templateUrl: "templates/following.html",
            controller: 'FollowingCtrl'
          }
        }
      })
      // 关注者
      .state('tabs.follower', {
        url: "/follower",
        views: {
          'my-tab': {
            templateUrl: "templates/follower.html",
            controller: 'FollowingCtrl'//暂时用一个
          }
        }
      })

    // 个人信息
    // .state('tabs.myinfo', {
    //     url: "/myinfo",
    //     views: {
    //         'my-tab': {
    //             templateUrl: "templates/myinfo.html",
    //             controller: 'DiscoverCtrl'
    //         }
    //     }
    // });


    $urlRouterProvider.otherwise("login");

  });



app.directive('hideTabs', function($rootScope) {
  return {
      restrict: 'A',
      link: function(scope, element, attributes) {
          scope.$on('$ionicView.beforeEnter', function() {
              scope.$watch(attributes.hideTabs, function(value){
                  $rootScope.hideTabs = value;
              });
          });

          scope.$on('$ionicView.beforeLeave', function() {
              $rootScope.hideTabs = false;
          });
      }
  };
});
