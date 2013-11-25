var app = angular.module("gitApp", []);

app.service("commitsService", ["$rootScope", "$http", function($rootScope, $http){
  return {
    commits: [],
    loadCommits: function() {
      var _this = this
      $http.get("/commits.json").success(function(data, status, headers, config){
        _this.commits = data;
        $rootScope.$broadcast("commits.loaded");
      })
    },
    selectCommit: function(sha) {
      var _this = this;
      $http.get("/commit/" + sha).success(function(data, status, headers, config){
        _this.selectedCommit = data;
        $rootScope.$broadcast("commits.commitSelected");
      })
    }
  }
}])

app.controller("commitsController", ["$scope", "commitsService", function($scope, commitsService){
  $scope.commits = commitsService.commits

  $scope.$on("commits.loaded", function(){
    $scope.commits = commitsService.commits
  })

  commitsService.loadCommits();
}]);

app.controller("commitController", ["$scope", "commitsService", function($scope, commitsService){
  $scope.files = []
  $scope.$on("commits.commitSelected", function(){
    console.log("foo")
    $scope.files = commitsService.selectedCommit
  })
}])

app.directive("commitList", function(){
  return {
    restrict: "A",
    link: function(scope, element, attrs) {
      var height = $("body").height() - $(element).offset().top
      $(element).css({height: height})
    }
  }
})

app.directive("commit", ["commitsService", function(commitsService){
  return {
    restrict: "E",
    scope: {
      commit: "="
    },
    template: "<li>" +
      "<a>{{commit.message}}</a>" +
      "</li>",
    link: function(scope, element, attrs) {
      element.bind("click", function(e){
        commitsService.selectCommit(scope.commit.sha)
      });
    }
  }
}]);
