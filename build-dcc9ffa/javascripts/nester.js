(function() {
  var app, kneeHtml, treeHtml;

  app = angular.module("myApp", []);

  treeHtml = "<div class=\"blue\" style=\"padding-left:10px;\">\n   <div>{{node.name}}\n   \n   <button ng-click=\"add(node)\">+</button>\n   <button ng-hide=\"parent == undefined\" ng-click=\"delete(parent, node)\">x</button>\n\n </div>\n\n   <div ng-repeat=\"child in node.children\">\n     <tree node=\"child\" parent=\"node\"></tree>\n        </div>\n</div>\n";

  kneeHtml = "<div class=\"yellow\" style=\"padding-left:10px;\">\n   <div>{{node.name}}\n   <p><a ng-click=\"showHide=!showHide\">Toggle State: {{!!showHide}}</a></p>\n   <button ng-click=\"add(node)\">+</button>\n   <button ng-hide=\"parent == undefined\" ng-click=\"delete(parent, node)\">x</button>\n\n </div>\n\n   <div ng-repeat=\"child in node.children\">\n     <tree node=\"child\" parent=\"node\"></tree>\n        </div>\n</div>\n";

  app.directive('tree', function($compile) {
    return {
      restrict: 'E',
      scope: {
        node: "=",
        parent: "="
      },
      link: function(scope, elem, attrs) {
        return elem.append(($compile(treeHtml))(scope));
      }
    };
  });

  app.directive('knee', function($compile) {
    return {
      restrict: 'E',
      scope: {
        node: "=",
        parent: "="
      },
      link: function(scope, elem, attrs) {
        return elem.append(($compile(kneeHtml))(scope));
      }
    };
  });

  this.MyCtrl = function($scope) {
    return $scope.root = {
      name: "root",
      children: [
        {
          name: "Child 1",
          children: []
        }, {
          name: "Child 2",
          children: []
        }
      ]
    };
  };

}).call(this);
