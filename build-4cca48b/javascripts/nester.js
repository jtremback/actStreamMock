(function() {
  var app, fleeHtml, kneeHtml, treeHtml;

  app = angular.module("myApp", []);

  fleeHtml = "<div class=\"green\" style=\"padding-left:10px;\">\n   <div>{{node.name}}\n   \n </div>\n\n   <div ng-repeat=\"child in node.children\">\n     <knee node=\"child\" parent=\"node\"></tree>\n        </div>\n</div>";

  treeHtml = "<div class=\"blue\" style=\"padding-left:10px;\">\n   <div>{{node.name}}\n   \n </div>\n\n   <div ng-repeat=\"child in node.children\">\n     <tree node=\"child\" parent=\"node\"></tree>\n        </div>\n</div>\n";

  kneeHtml = "<div ng-click=\"showHide=!showHide\" class=\"red\" style=\"padding-left:10px;\">\n   <div>{{node.name}}\n   <p><a>Toggle State: {{!!showHide}}</a></p>\n   \n </div>\n\n   <div ng-hide=\"showHide\" ng-repeat=\"child in node.children\">\n     <tree node=\"child\" parent=\"node\"></tree>\n        </div>\n</div>\n";

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

  app.directive('flee', function($compile) {
    return {
      restrict: 'E',
      scope: {
        node: "=",
        parent: "="
      },
      link: function(scope, elem, attrs) {
        return elem.append(($compile(fleeHtml))(scope));
      }
    };
  });

  this.ThyCtrl = function($scope) {
    return $scope.annotations = [
      {
        name: "RLCoolstein",
        time: "about 3 hours ago",
        page: "Courageous class battlecruiser - Wikipedia, the free encyclopedia",
        link: "http://en.wikipedia.org/wiki/Courageous_class_battlecruiser",
        excerpt: "The Courageous class comprised three battlecruisers built for the Royal Navy during World War I. Nominally designed to support Admiral of the Fleet Lord John Fisher's Baltic Project, which was intended to land troops on the German Baltic Coast, ships of this class were fast but very lightly armoured with only a few heavy guns. To maximize their speed, the Courageous-class battlecruisers were the first capital ships of the Royal Navy to use geared steam turbines and small-tube boilers. ",
        text: "<p>I have two separate editions of Brooks, with two difference sets of pagination. In neither edition, on page 170, is there anything to actually confirm, Data from a 15-foot (4.6 m) rangefinder in the armoured hood was input into a Mk IV* Dreyer Fire Control Table located in the Transmitting Station (TS) where it was converted into range and deflection data for use by the guns. I would suggest a closer reading of the pages involved.</p>"
      }, {
        name: "RLCoolstein",
        time: "about 3 hours ago",
        page: "Courageous class battlecruiser - Wikipedia, the free encyclopedia",
        link: "http://en.wikipedia.org/wiki/Courageous_class_battlecruiser",
        excerpt: "The Courageous class comprised three battlecruisers built for the Royal Navy during World War I. Nominally designed to support Admiral of the Fleet Lord John Fisher's Baltic Project, which was intended to land troops on the German Baltic Coast, ships of this class were fast but very lightly armoured with only a few heavy guns. To maximize their speed, the Courageous-class battlecruisers were the first capital ships of the Royal Navy to use geared steam turbines and small-tube boilers. ",
        text: "<p>I have two separate editions of Brooks, with two difference sets of pagination. In neither edition, on page 170, is there anything to actually confirm, Data from a 15-foot (4.6 m) rangefinder in the armoured hood was input into a Mk IV* Dreyer Fire Control Table located in the Transmitting Station (TS) where it was converted into range and deflection data for use by the guns. I would suggest a closer reading of the pages involved.</p>"
      }
    ];
  };

  this.MyCtrl = function($scope) {
    $scope.roots = {
      name: "My Annotations List",
      children: [
        {
          name: "Annotation 1",
          children: [
            {
              name: "Reply 1",
              children: []
            }, {
              name: "Reply 2",
              children: []
            }
          ]
        }, {
          name: "Annotation 2",
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
