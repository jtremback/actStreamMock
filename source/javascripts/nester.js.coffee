app = angular.module("myApp", [])

otherHtml =
  """
    <knee node='{{}}'

  """

treeHtml =
  """
 <div class="blue" style="padding-left:10px;">
    <div>{{node.name}}
    
  </div>

    <div ng-repeat="child in node.children">
      <tree node="child" parent="node"></tree>
         </div>
 </div>

  """

kneeHtml =
  """
 <div ng-click="showHide=!showHide" class="red" style="padding-left:10px;">
    <div>{{node.name}}
    <p><a>Toggle State: {{!!showHide}}</a></p>
    
  </div>

    <div ng-hide="showHide" ng-repeat="child in node.children">
      <tree node="child" parent="node"></tree>
         </div>
 </div>

  """

fleeHtml =
  """
 <div ng-click="showHide=!showHide" class="green" style="padding-left:10px;">
    <div>{{node.name}}
    <p><a>Toggle State: {{!!showHide}}</a></p>
    
  </div>

    <div ng-hide="showHide" ng-repeat="child in node.children">
      <knee node="child" parent="node"></tree>
         </div>
 </div>
  """
    
# Identifies directives in html
app.directive 'tree', ($compile) -> {
# Makes sure that elements with 'tree' as the element name are used
  restrict: 'E',
# Not sure exactly what this does, has something to do with nesting
  scope: {
    node: "="
    parent: "="
  }
# Calls in correct html
  link : (scope, elem, attrs) ->
    elem.append ($compile treeHtml) scope
}



app.directive 'knee', ($compile) -> {

restrict: 'E',
scope: {
  node: "="
  parent: "="
}

link : (scope, elem, attrs) ->
  elem.append ($compile kneeHtml) scope
}

app.directive 'flee', ($compile) -> {

restrict: 'E',
scope: {
  node: "="
  parent: "="
}

link : (scope, elem, attrs) ->
  elem.append ($compile fleeHtml) scope
}

@ThyCtrl = ($scope) ->

  $scope.annotations = [
    name: "RLCoolstein"
    time: "about 3 hours ago"
    page: "Courageous class battlecruiser - Wikipedia, the free encyclopedia"
    link: "http://en.wikipedia.org/wiki/Courageous_class_battlecruiser"
    excerpt: "The Courageous class comprised three battlecruisers built for the Royal Navy during World War I. Nominally designed to support Admiral of the Fleet Lord John Fisher's Baltic Project, which was intended to land troops on the German Baltic Coast, ships of this class were fast but very lightly armoured with only a few heavy guns. To maximize their speed, the Courageous-class battlecruisers were the first capital ships of the Royal Navy to use geared steam turbines and small-tube boilers. "
    text: "<p>I have two separate editions of Brooks, with two difference sets of pagination. In neither edition, on page 170, is there anything to actually confirm, Data from a 15-foot (4.6 m) rangefinder in the armoured hood was input into a Mk IV* Dreyer Fire Control Table located in the Transmitting Station (TS) where it was converted into range and deflection data for use by the guns. I would suggest a closer reading of the pages involved.</p>"
  ,
    name: "RLCoolstein"
    time: "about 3 hours ago"
    page: "Courageous class battlecruiser - Wikipedia, the free encyclopedia"
    link: "http://en.wikipedia.org/wiki/Courageous_class_battlecruiser"
    excerpt: "The Courageous class comprised three battlecruisers built for the Royal Navy during World War I. Nominally designed to support Admiral of the Fleet Lord John Fisher's Baltic Project, which was intended to land troops on the German Baltic Coast, ships of this class were fast but very lightly armoured with only a few heavy guns. To maximize their speed, the Courageous-class battlecruisers were the first capital ships of the Royal Navy to use geared steam turbines and small-tube boilers. "
    text: "<p>I have two separate editions of Brooks, with two difference sets of pagination. In neither edition, on page 170, is there anything to actually confirm, Data from a 15-foot (4.6 m) rangefinder in the armoured hood was input into a Mk IV* Dreyer Fire Control Table located in the Transmitting Station (TS) where it was converted into range and deflection data for use by the guns. I would suggest a closer reading of the pages involved.</p>"
  ]

@OtherCtrl = ($scope) ->

  $scope.list = [
   
    name: "roots",
    name: "foots",
    name: "boots"

  ]

@MyCtrl = ($scope) ->

  $scope.roots = {

    name : "root"
    children : [ 
      {name : "Child 1", 
      children : [
        {name : "Grandchild 1",
        children : [] }
        ] }, 
      
      {name : "Child 2", 
      children : [] }
    ],
    name : "root2"
    children : [ 
      {name : "Child 1", 
      children : [
        {name : "Grandchild 1",
        children : [] }
        ] }, 
      
      {name : "Child 2", 
      children : [] }
    ]
  }

  $scope.foots = {

    name : "foot"
    children : [ 
      {name : "Child 1", 
      children : [
        {name : "Grandchild 1",
        children : [] }
        ] }, 
      
      {name : "Child 2", 
      children : [] }
    ]
  }

  $scope.boots = {

    name : "boot"
    children : [ 
      {name : "Child 1", 
      children : [
        {name : "Grandchild 1",
        children : [] }
        ] }, 
      
      {name : "Child 2", 
      children : [] }
    ]
  }


