app = angular.module("myApp", [])

#Templating for list
app.directive 'list', ($compile) -> {

restrict: 'E',
scope: {
  node: "="
  parent: "="
}

link : (scope, elem, attrs) ->
  elem.append ($compile listHtml) scope
}

listHtml =
  """
 <div id="stream">
    <div>{{node.name}}</div>

    <div ng-repeat="child in node.children">
      <anno node="child" parent="node"></anno>
    </div>
 </div>
  """

#Templating for annotations
app.directive 'anno', ($compile) -> {

restrict: 'E',
scope: {
  node: "="
  parent: "="
}

link : (scope, elem, attrs) ->
  elem.append ($compile annoHtml) scope
}

annoHtml =
  """
<div class="tile">
  <div class="hyp-paper hyp-excerpt">
    <a href="{{node.link}}">{{node.page}}</a>
    <blockquote>
      {{node.excerpt}}
    </blockquote>
  </div>  
  <li class="hyp-annotation hyp-paper hyp-detail" ng-click="showHide=!showHide">   
    <div class="topbar">
      <div class="hyp-user">{{node.name}}</div>
      <div class="hyp-time">{{node.time}}</div>
    </div>    
    <div class="hyp-content">{{render(node.text)}}</div>    
    <div class="hyp-thread">
      <ul class="annotator-listing" ng-hide="showHide" ng-repeat="child in node.children">
        <tree node="child" parent="node"></tree>
      </ul>
    </div>
  </li>
</div>

  """

# Templating for replies tree
app.directive 'tree', ($compile) -> {

  restrict: 'E',
  scope: {
    node: "="
    parent: "="
  }

  link : (scope, elem, attrs) ->
    elem.append ($compile treeHtml) scope
}

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


@MyCtrl = ($scope) ->

  $scope.roots = {

    name : "New Annotations"
    children : [ 
      {
        username: "RLCoolstein",
        time: "about 3 hours ago",
        page: "Courageous class battlecruiser - Wikipedia, the free encyclopedia",
        link: "http://en.wikipedia.org/wiki/Courageous_class_battlecruiser",
        excerpt: "The Courageous class comprised three battlecruisers built for the Royal Navy during World War I. Nominally designed to support Admiral of the Fleet Lord John Fisher's Baltic Project, which was intended to land troops on the German Baltic Coast, ships of this class were fast but very lightly armoured with only a few heavy guns. To maximize their speed, the Courageous-class battlecruisers were the first capital ships of the Royal Navy to use geared steam turbines and small-tube boilers. ",
        text: "<p>I have two separate editions of Brooks, with two difference sets of pagination. In neither edition, on page 170, is there anything to actually confirm, Data from a 15-foot (4.6 m) rangefinder in the armoured hood was input into a Mk IV* Dreyer Fire Control Table located in the Transmitting Station (TS) where it was converted into range and deflection data for use by the guns. I would suggest a closer reading of the pages involved.</p>"
      },
      {
        username: "RLCoolstein",
        time: "about 3 hours ago",
        page: "Courageous class battlecruiser - Wikipedia, the free encyclopedia",
        link: "http://en.wikipedia.org/wiki/Courageous_class_battlecruiser",
        excerpt: "The Courageous class comprised three battlecruisers built for the Royal Navy during World War I. Nominally designed to support Admiral of the Fleet Lord John Fisher's Baltic Project, which was intended to land troops on the German Baltic Coast, ships of this class were fast but very lightly armoured with only a few heavy guns. To maximize their speed, the Courageous-class battlecruisers were the first capital ships of the Royal Navy to use geared steam turbines and small-tube boilers. ",
        text: "<p>I have two separate editions of Brooks, with two difference sets of pagination. In neither edition, on page 170, is there anything to actually confirm, Data from a 15-foot (4.6 m) rangefinder in the armoured hood was input into a Mk IV* Dreyer Fire Control Table located in the Transmitting Station (TS) where it was converted into range and deflection data for use by the guns. I would suggest a closer reading of the pages involved.</p>"
      }
    ]

  }

