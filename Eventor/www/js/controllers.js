(
  function(){
      Array.prototype.removeByValue = function(val) {
      for(var i=0; i<this.length; i++) {
          if(this[i] == val) {
          this.splice(i, 1);
          break;
          }
      }
      }
  }
)();


angular.module('starter.controllers', ["Server"])
  //
    .controller('LoginCtrl', function ($scope, $http, $timeout, $ionicPopup, $state, $rootScope,Server) {
        $scope.data = {};
       //     "nickname": "",
       //     "username": "",
       //     "password": "",
       // };
        $scope.login = function () {
            var reqdata = $scope.data;
            Server.fetch('/index.php/user/login',reqdata,function(res){
                if(res["code"]== 0){
                    $rootScope.info = res["row"]
                    var alertPopup = $ionicPopup.alert({
                        title: 'Login !',
                        template: 'successed!'
                    });
                    $state.go('tabs.home');
                }
            })          
        }

        $scope.signup = function () {
            var reqdata = $scope.data;
            Server.fetch('/index.php/user/register',reqdata,function(res){
                if(res["code"]== 0){
                    $rootScope.info = res["row"]
                    var alertPopup = $ionicPopup.alert({
                        title: 'Signup !',
                        template: 'successed!'
                    });
                    $state.go('login');
                }
            })
        }
    })


  // 发布事件
  .controller('createCtrl', function ($scope, $ionicActionSheet, $timeout, $ionicPopup, $rootScope, $state, Server) {
    $scope.title = 'Event Edit'
    $scope.data = {
      "category": "ALL",
      "title": "",
      "description": "",
      "organizer": "",
      "location": "",
      "start": "",
      "max": ""
    };
    // "image"

    $scope.publish = function () {
      var reqdata = $scope.data;
      reqdata["max"] = parseInt(reqdata["max"]) || 30;
      Server.fetch('/index.php/event/publish', reqdata, function (res) {
        if (res["code"] == 0) {
          var alertPopup = $ionicPopup.alert({
            title: 'Message !',
            template: 'public event successed!'
          });
        }
      })

    }

    $scope.categoryArr = ["sports", "workshop", "entertainment", "ALL"]
    $scope.showCategory = function () {
      var hideSheet = $ionicActionSheet.show({
        buttons: [
          { text: '<b>Sports</b>' },
          { text: '<b>Workshop</b>' },
          { text: '<b>Entertainment</b>' },
          { text: '<b>ALL</b>' }
        ],
        titleText: 'Seleted Category',
        cancelText: 'Cancel',
        // cancel: function () { },
        buttonClicked: function (index) {
          $scope.data.category = $scope.categoryArr[index]
          return true;
        }
      });
      $timeout(function () {
        hideSheet();
        hideSheet = null;
      }, 5000);
    };

    if (!$rootScope.info) { $state.go('login'); }

  })



  .controller('HomeCtrl', function ($scope, $ionicActionSheet, $timeout, $rootScope, $state, $ionicPopup, Server) {

    $scope.apiHost = Server.host;
    $scope.loadMoreIf = true;
    $scope.data = {
      showDelete: false
    };
    $scope.unlike = function (item) {
      $scope.items.removeByValue(item)
    };

    $scope.research = function (kw) {
      $scope.kw = kw || "";
      $scope.items = [];
      $scope.page = 0;
      $scope.total = 0;
      $scope.last = 0;
      $scope.size = 10;
      $scope.refresh();
    }

    $scope.refresh = function () {
      $scope.loadMoreIf = true;
      var oldPage = $scope.page;
      $scope.page++;
      var reqUrl = '/index.php/event/search?kw=' + $scope.kw + '&page=' + $scope.page + "&size=" + $scope.size;
      Server.fetch(reqUrl, function (res) {
        if (res["code"] == 0) {
          var result = res["result"]
          var curPage = $scope.page = parseInt(result["current_page"]);
          if (curPage > oldPage) {
            $scope.total = parseInt(result["total"]);
            $scope.last = parseInt(result["last_page"]);
            $scope.size = parseInt(result["per_page"]);
            $scope.items = $scope.items.concat(result["data"]);
          } else {
            $scope.loadMoreIf = false;
            var alertPopup = $ionicPopup.alert({
              title: 'Message',
              template: "没有更多的数据了~~"
            });
          }
        }
        $scope.$broadcast('scroll.infiniteScrollComplete');
        $scope.$broadcast('scroll.refreshComplete');
      })
    }

    $scope.research();
  })


  .controller('DiscoverCtrl', function ($scope, $ionicActionSheet, $timeout, $ionicPopup, Server) {
    $scope.apiHost = Server.host;
    $scope.loadMoreIf = true;
    $scope.category = "ALL";
    $scope.categoryArr = ["sports", "workshop", "entertainment", "ALL"]
    $scope.showCategory = function () {
      var hideSheet = $ionicActionSheet.show({
        buttons: [
          { text: '<b>Sports</b>' },
          { text: '<b>Workshop</b>' },
          { text: '<b>Entertainment</b>' },
          { text: '<b>ALL</b>' }
        ],
        titleText: 'Seleted Category',
        cancelText: 'Cancel',
        // cancel: function () { },
        buttonClicked: function (index) {
          $scope.category = $scope.categoryArr[index];
          $scope.research()
          return true;
        }
      });
      $timeout(function () {
        hideSheet();
        hideSheet = null;
      }, 5000);
    };
    $scope.order = "Default";
    $scope.orderArr = ["start", "like", "join", "default"];
    $scope.showOrder = function () {
      var hideSheet = $ionicActionSheet.show({
        buttons: [
          { text: '<b>Date</b>' },
          { text: '<b>Hottest</b>' },
          { text: '<b>Join</b>' },
          { text: '<b>Default</b>' }
        ],
        titleText: 'Selecte Order By',
        cancelText: 'Cancel',
        // cancel: function () { },
        buttonClicked: function (index) {
          $scope.order = $scope.orderArr[index];
          $scope.research()
          return true;
        }
      });
      $timeout(function () {
        hideSheet();
        hideSheet = null;
      }, 5000);
    };

    $scope.data = {
      showDelete: false
    };
    $scope.unlike = function (item) {
      $scope.items.removeByValue(item)
    };

    $scope.research = function (kw) {
      $scope.kw = kw || $scope.kw || "";
      $scope.items = [];
      $scope.page = 0;
      $scope.total = 0;
      $scope.last = 0;
      $scope.size = 10;
      $scope.refresh();
    }

    $scope.refresh = function () {
      $scope.loadMoreIf = true;
      var oldPage = $scope.page;
      $scope.page++;
      var reqdata = {}
      if ($scope.category !== "ALL") {
        reqdata["category"] = $scope.category;
      }
      if ($scope.order !== "default") {
        reqdata["start"] = "desc";
        reqdata[$scope.order] = "desc";
      }
      var reqUrl = '/index.php/event/search?&kw=' + $scope.kw + '&page=' + $scope.page + "&size=" + $scope.size;
      Server.fetch(reqUrl, reqdata, function (res) {
        if (res["code"] == 0) {
          var result = res["result"]
          var curPage = $scope.page = parseInt(result["current_page"]);
          if (curPage > oldPage) {
            $scope.total = parseInt(result["total"]);
            $scope.last = parseInt(result["last_page"]);
            $scope.size = parseInt(result["per_page"]);
            $scope.items = $scope.items.concat(result["data"]);
          } else {
            $scope.loadMoreIf = false;
            var alertPopup = $ionicPopup.alert({
              title: 'Message',
              template: "没有更多的数据了~~"
            });
          }
        }
        $scope.$broadcast('scroll.infiniteScrollComplete');
        $scope.$broadcast('scroll.refreshComplete');
      })
    }
    $scope.research("");

  })



  //Event 详情页
  .controller('EventCtrl', function ($scope, $stateParams, Server) {
    $scope.apiHost = Server.host;
    $scope.eid = parseInt($stateParams.eid) || 1;
    $scope.data = {};
    // Event详情
    $scope.update = function () {
      var reqData = {
        "eid": $scope.eid
      }
      Server.fetch("/index.php/event/info", reqData, function (res) {
        if (res["code"] == 0) {
          $scope.data = res["row"]
        }
      })
    };


    $scope.state = {
      "like": false,
      "join": false,
      "chat": false
    };
    // 用户关联更新状态
    // type ( like,join,chat ) state(0 表示false  1  表示true)
    $scope.updateState = function (type, state) {
      var reqData = {
        "eid": $scope.eid
      }
      if (type) {
        reqData[type] = state || "1"
      }
      Server.fetch("/index.php/event/state", reqData, function (res) {
        if (res["code"] == 0) {
          $scope.state = res["data"]
        }
      })
    }

    $scope.update()
    $scope.updateState()

  })



  .controller('FollowingCtrl', function ($scope) {
    $scope.apiHost = Server.host;
    $scope.items = [
      { id: 1, avatar: "static/img/user.jpg", nickname: "AAAA" },
      { id: 2, avatar: "static/img/user.jpg", nickname: "AAAA" },
      { id: 3, avatar: "static/img/user.jpg", nickname: "AAAA" },
      { id: 4, avatar: "static/img/user.jpg", nickname: "AAAA" },
      { id: 5, avatar: "static/img/user.jpg", nickname: "AAAA" },
    ];
    $scope.data = {
      showDelete: false
    };
    $scope.unFollow = function (item) {
      alert("UnFollow " + item.nickname)
    };
  })


  // 聊天列表
  .controller('ChatListCtrl', function ($scope, Server) {
    $scope.apiHost = Server.host;
    $scope.data = {
      showDelete: false
    };
    $scope.unlike = function (item) {
      alert('Edit Item: ' + item.title);
    };
    $scope.items = [];
    $scope.update = function () {
      var reqData = {}
      Server.fetch("/index.php/chat/group", reqData, function (res) {
        if (res["code"] == 0) {
          $scope.items = res["data"]
        }
      })
    }
    $scope.update()

    // 5秒更新一次
    setInterval(function () {
      $scope.update()
    }, 5000)

  })


  .controller('ChattingCtrl', function ($scope, $stateParams, $ionicScrollDelegate, Server) {
    $scope.apiHost = Server.host;
    $scope.items = [];
    $scope.msg = "";
    $scope.eid = parseInt($stateParams.eid) || 1;
    $scope.last = new Date()
    $scope.update = function () {
      var reqData = { "eid": $scope.eid }
      Server.fetch("/index.php/chat/history", reqData, function (res) {
        if (res["code"] == 0) {

          $scope.items = res["data"];
          $ionicScrollDelegate.$getByHandle('mainScroll').scrollBottom();
        }
      })
    }

    $scope.update()
    setInterval(function () {
      $scope.update()
      // 30秒更新一次
    }, 30000)

    $scope.send = function () {
      var reqData = { "eid": $scope.eid, "msg": $scope.msg }
      Server.fetch("/index.php/chat/send", reqData, function (res) {
        if (res["code"] == 0) {
          $scope.msg = ""
          $scope.items.push(res["data"])
          $ionicScrollDelegate.$getByHandle('mainScroll').scrollBottom();

        }
      })
    }

  })


  // usercenter 
  .controller('UcenterCtrl', function ($scope, $state, $rootScope, Server) {
    $scope.apiHost = Server.host;
    if (!$rootScope.info) { $state.go('login'); }

    $scope.logout = function () {
      Server.fetch("/user/logout", {}, function (res) {
        $state.go('login');
      })
    };
  })


  //个人主页（任意人的主页）
  .controller('UserInfoCtrl', function ($scope, $rootScope, $ionicPopup, $stateParams, Server, $state) {
    $scope.apiHost = Server.host;
    // 如果没有就是当前用户的uid
    $scope.uid = parseInt($stateParams.uid);
    // create   ||   join  两种类型
    $scope.type = $stateParams.type === "join" ? "join" : "create"
    $scope.changeType = function (t) {
      $scope.refresh()
      $scope.type = (t === "join" ? "join" : "create");
    }

    // 个人信息 （）
    $scope.user = {};
    $scope.updateUser = function () {
      Server.fetch("/user/info", {}, function (res) {
        if (res["code"] == 0) {
          $scope.user = res["data"];
        }
      })
    }

    $scope.items = []
    $scope.refresh = function () {
      var reqData = {}
      if ($scope.uid) { reqData["uid"] = $scope.uid };
      var reqUrl = "/user/" + ($scope.type === "join" ? "join" : "create")
      Server.fetch(reqUrl, reqData, function (res) {
        if (res["code"] == 0) {
          $scope.items = res["data"];
        }
      })
    }
    if (!$rootScope.info) {
      $state.go('login');
      return
    }
    $scope.refresh();
  })



