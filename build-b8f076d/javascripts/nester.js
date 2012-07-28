(function() {
  var app, kneeHtml, treeHtml;

  app = angular.module("myApp", []);

  treeHtml = "<div class=\"blue\" style=\"padding-left:10px;\">\n   <div>{{node.name}}\n   \n </div>\n\n   <div ng-repeat=\"child in node.children\">\n     <tree node=\"child\" parent=\"node\"></tree>\n        </div>\n</div>\n";

  kneeHtml = "<div ng-click=\"showHide=!showHide\" class=\"yellow\" style=\"padding-left:10px;\">\n   <div>{{node.name}}\n   <p><a>Toggle State: {{!!showHide}}</a></p>\n   \n </div>\n\n   <div ng-hide=\"showHide\" ng-repeat=\"child in node.children\">\n     <tree node=\"child\" parent=\"node\"></tree>\n        </div>\n</div>\n";

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
    $scope.roots = {
      name: "root",
      children: [
        {
          name: "Child 1",
          children: [
            {
              name: "Grandchild 1",
              children: []
            }
          ]
        }, {
          name: "Child 2",
          children: []
        }
      ],
      name: "root2",
      children: [
        {
          name: "Child 1",
          children: [
            {
              name: "Grandchild 1",
              children: []
            }
          ]
        }, {
          name: "Child 2",
          children: []
        }
      ]
    };
    $scope.foots = {
      name: "foot",
      children: [
        {
          name: "Child 1",
          children: [
            {
              name: "Grandchild 1",
              children: []
            }
          ]
        }, {
          name: "Child 2",
          children: []
        }
      ]
    };
    return $scope.boots = {
      name: "boot",
      children: [
        {
          name: "Child 1",
          children: [
            {
              name: "Grandchild 1",
              children: []
            }
          ]
        }, {
          name: "Child 2",
          children: []
        }
      ]
    };
  };

}).call(this);
