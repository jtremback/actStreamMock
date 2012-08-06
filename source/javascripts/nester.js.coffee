app = angular.module("myApp", ["filters"])

###
Truncate Filter
@Param text
@Param length, default is 10
@Param end, default is "..."
@return string
###
angular.module("filters", []).filter "truncate", ->
  (text, length, end) ->
    length = text.length if isNaN(length)
    end = "..."  if end is `undefined`
    if text.length <= length or text.length - end.length <= length
      text
    else
      String(text).substring(0, length - end.length) + end

###
Usage

var myText = "This is an example.";

{{myText|Truncate}}
{{myText|Truncate:5}}
{{myText|Truncate:25:" ->"}}
Output
"This is..."
"Th..."
"This is an e ->"
###

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
  <ul class="annotator-widget annotator-listing">
      <div anno="exp" class="tile" ng-repeat="child in node.children" node="child" parent="node"></div>
  </ul>
</div>
  """

#Templating for annotations
app.directive 'anno', ($compile) -> {

scope: {
  node: "="
  parent: "="
}

link : (scope, elem, attrs) ->
  elem.append ($compile annoHtml) scope
}


#   <div class="metadata"><a>JordanLikesCoffee</a></div>
# <div class="control">
#   <a class="goto"><div class="inner">To Annotation</div></a>
# </div>
# <div class="control">
#   <a class="fave"><div class="inner">Favorite</div></a>
# </div>


annoHtml =
  """
<ul class="annotator-widget annotator-listing">
  <li class="sidepanel">
    <div class="avablock">
      <img class="ava" src="images/avatar_1.jpg"/>
    </div>
  <div class="metadata"><a>JordanLikesCoffee</a></div>
  <div class="control">
    <a class="goto"><div class="inner">To Annotation</div></a>
  </div>
  <div class="control">
    <a class="fave"><div class="inner">Favorite</div></a>
  </div>
  </li>

  <li class="hyp-annotation hyp-paper hyp-detail hyp-excerpt" ng-click="showHide=!showHide">   
    <div class="page">
      <a href="{{node.link}}">{{node.page|truncate:60}}</a>
      <div class="domain">{{node.domain}}<img class="favicon" ng-src="http://{{node.domain}}/favicon.ico"/>
      </div>
    </div>
    <blockquote ng-show="node.srclevel">
      {{node.excerpt|truncate:140}}
    </blockquote>
    <div class="topbar">
      <div class="hyp-user">{{node.username}}</div>
      <div class="hyp-time">{{node.time}}</div>
    </div>    
    <div class="hyp-content">{{node.text|truncate:200}}</div>    
    <div class="hyp-thread">
      <ul class="annotator-listing" ng-show="showHide">

      <li tree="exp" class="hyp-annotation hyp-detail" ng-repeat="child in node.children" node="child" parent="node"></li>

      </ul>
    </div>
  </li>
</ul>


  """

# Templating for replies tree
app.directive 'tree', ($compile) -> {

  replace: true,
  scope: {
    node: "="
    parent: "="
  }

  link : (scope, elem, attrs) ->
    elem.append ($compile treeHtml) scope
}

treeHtml =
  """
<a class="hyp-threadexp" href="#collapse"></a>
<div class="topbar">
  <div class="hyp-user">{{node.username}}</div>
  <div class="hyp-time">{{node.time}}</div>
</div>
<div class="hyp-content">{{node.text}}</div>
<div class="hyp-thread">
  <ul class="annotator-listing"> 

      <li tree="exp" class="hyp-annotation hyp-detail" ng-repeat="child in node.children" node="child" parent="node"></li>

  </ul>
</div>

  """
  # <div class="annotator-controls">
  #  <a href="#reply" class="hyp-write">Reply</a>
  # </div>

@MyCtrl = ($scope) ->

  $scope.roots = {

    name : "New Annotations"
    children : [ 
      {
        username: "RLCoolstein",
        time: "about 3 hours ago",
        page: "Courageous class battlecruiser - Wikipedia, the free encyclopedia",
        link: "http://en.wikipedia.org/wiki/Courageous_class_battlecruiser",
        domain: "wikipedia.org",
        srclevel: true,
        excerpt: "The Courageous class comprised three battlecruisers built for the Royal Navy during World War I. Nominally designed to support Admiral of the Fleet Lord John Fisher's Baltic Project, which was intended to land troops on the German Baltic Coast, ships of this class were fast but very lightly armoured with only a few heavy guns. To maximize their speed, the Courageous-class battlecruisers were the first capital ships of the Royal Navy to use geared steam turbines and small-tube boilers. ",
        text: "I have two separate editions of Brooks, with two difference sets of pagination. In neither edition, on page 170, is there anything to actually confirm, Data from a 15-foot (4.6 m) rangefinder in the armoured hood was input into a Mk IV* Dreyer Fire Control Table located in the Transmitting Station (TS) where it was converted into range and deflection data for use by the guns. I would suggest a closer reading of the pages involved.",
        children : [
          {
            username: "Speciality",
            time: "about 1 hour ago",
            text: "I don't know what's going on with your books, but I just checked my 1987 edition and it states exactly that"
            children: [
              {
                username: "RLCoolstein",
                time: "57 minutes ago",
                text: "We need to get to the bottom of this."
              },
              {
                username: "Bozo",
                time: "30 minutes ago",
                text: "Weird discrepancy."
              }
            ]
          }
        ]
      },
      {
        username: "Velvet_Jesus",
        time: "about 3 day ago",
        page: "China cancels waste project after protests turn violent | Reuters",
        link: "http://www.reuters.com/article/2012/07/28/us-china-environment-protest-idUSBRE86R02Y20120728",
        domain: "reuters.com",
        srclevel: true,
        excerpt: "Demonstrators seized bottles of liquor and wine from the offices along with cartons of cigarettes, items which Chinese officials frequently receive as bribes. A photograph posted on Sina Weibo, the main Chinese microblogging service, showed some of the items displayed outside the government building.",
        text: "Chinese officials sound really easy to bribe."
        children : [
          {
            username: "notouch",
            time: "about 1 day ago",
            text: "Just talked to someone who came here from China. Apparently foreign liquor and cigarettes cost ten-fold of its original price, if not more. So these things are easily $100 each. Not to mention these were only items found in the office, not their private mansion. Also learned that it's very common to treat someone to dinner or a massage parlor as form of bribery. A good fancy dinner cost a few hundred dollars, even thousands of dollars. The massage parlor usually offer some special kind of service in the back-end."
            children: [
              {
                username: "elmer_the_arse",
                time: "about 1 day ago",
                text: "what if the corrupt official does't like 'the special kind of service in the back end'?"
                children: [
                  {
                    username: 'notouch',
                    time: "about 1 day ago",
                    text: "I'm sure they provide special service in the front end too. ;)"
                  }
                ]
              },
              {
                username: 'G0VERNMENT'
                time: 'about 22 hours ago'
                text: 'Ya, its called using back doors and is considered normal and is so common place that it borders on acceptable in Chinese culture.'
              }
            ]
          },
          {
            username: 'ponto1',
            time: 'about 1 day ago'
            text: 'China has had some of the most insanely fast economic growth of world history in the past couple of decades. Very few will protest until this kind of growth stops.',
            children: [
              {
                username: 'dingdongpuddi',
                time: 'about 1 day ago'
                text: "Actually there's been many reports on how little, if any, benefits of this decades-long growth for the poor and rural. Here's one such report: http://www.nytimes.com/2008/01/13/world/asia/13china.html?pagewanted=all"
                children: [
                  {
                    username: 'anarcho-fox',
                    time: 'about 1 day ago',
                    text: 'its becuase the chinese rural poor are the government sanctioned rural poor...they arent allowed to join into the urban growth because they are designated rural workers http://en.wikipedia.org/wiki/Hukou_system china has a form of caste system thats not talked about much...the government fears that ending it would catapult all the rural poor into the cities and that it would fuck everything up'
                    children: [
                      {
                        username: 'TBradley',
                        time: 'about 1 day ago',
                        text: 'Yep, they have an internal passport like system.'
                      },
                      {
                        username: 'Baraka_Flocka_Flame',
                        time: 'about 23 hours ago',
                        text: "I remember seeing a video on reddit a year or so ago where an economist was displaying the vast wealth disparities in china based on the province. Without really getting into details, it showed how many of the most industrialized urban areas had wealth equivalent to the wealthiest western nations while the rural areas had wealth equivalent to some of the poorest areas in Africa. I can't seem to find it though, anyone know what I'm talking about?",
                        children: [
                          {
                            username: 'AmIKawaiiUguuu',
                            time: 'about 20 hours ago',
                            text: 'http://www.economist.com/content/chinese_equivalents',
                            children: [
                              {
                                username: 'green_flash',
                                time: 'about 19 hours ago'
                                text: "If you look at GDP per capita, it's actually not that bad. Even the poorest province (Guizhou) is still on the same level as India.And with the exemption of city states like HK, Macau, Shanghai, Beijing and Tianjin no province is richer than 4 times the poorest.That's better than Brazil and India inequality-wise, but not as good as in the US of course: Mississippi has about half the GDP per capita of Connecticut, one of the richest."
                              }
                            ]
                          },
                          {
                            username: "jaylink",
                            time: "about 20 hours ago",
                            text: "Oh no, that could never happen here. Eastern Tennessee -vs- NYC, cough, cough. Compton -vs- Beverly Hills -- that's only a few miles."
                          }
                        ]
                      }
                    ]
                  }
                ]
              }
            ]
          }
        ]
      },
      {
        username: "jkn",
        time: "about 21 hours ago",
        page: "Microsoft Files Motion in Apple v. Samsung to Hide Patent License Agreement Terms ~pj",
        link: "http://groklaw.net/article.php?story=20120727084323510",
        domain: "groklaw.net",
        srclevel: false,
        excerpt: "I seriously want to see those license terms, and I'd go so far as to suggest that the public has a right to know what those terms are, particularly future victims of Microsoft's patent strategy, and I know you want to know this too, because we've all heard the rumors that Microsoft licenses on very, very low royalties, just to be able to say to the world that Android/Linux folks are paying Microsoft for its patents. I'd love to know if that is true. Plus, if Microsoft paid for Samsung's FRAND patents the fee Samsung is asking Apple for, on what basis would Microsoft argue in its litigation against Motorola, that FRAND patents should be paid for at a greatly reduced royalty?",
        text: "Seems to me that the article singles out Microsoft because it puts this motion in the context of Microsoft making secret patent deals with Android manufacturers:"
        children : [
          {
            username: "ChuckMcM",
            time: "about 18 hours ago",
            text: "This. I think it was more in line with wanting to know how much Microsoft is charging. I suspect its like salary negotiations where you don't want the other side to know what you've already agreed..."
          }
          # {
          #   username: "brettpiat",
          #   time: "about 18 hours ago",
          #   text: "My understanding is Microsoft is different. The difference is that RIM, Motorola, and Qualcomm are FRAND agreements for Samsung's patents rather than non-FRAND terms for Samsung licening patents from Microsoft. The first three worry that the documents will expose their trade secrets around how their devices work and what patents they need licenses for. Two different sides of the coin."
          # }
        ]
      },
      {
        username: "brudgers",
        time: "1 day ago",
        page: "How Microsoft Lost Its Mojo: Steve Ballmer and Corporate America’s Most Spectacular Decline | Business | Vanity Fair",
        link: "http://m.vanityfair.com/business/2012/08/microsoft-lost-mojo-steve-ballmer",
        domain: "m.vanityfair.com",
        srclevel: true,
        excerpt: "In December 2000, Microsoft had a market capitalization of $510 billion, making it the world’s most valuable company. As of June it is No. 3, with a market cap of $249 billion. In December 2000, Apple had a market cap of $4.8 billion and didn’t even make the list. As of this June it is No. 1 in the world, with a market cap of $541 billion.",
        text: "In other words, Apple is currently about where Microsoft was when they started paying dividends a little more than a decade ago...i.e. The point where they went from a growth company to a the sort of 'blue chip' held by index funds. The past decade has been spent securing their place in enterprise - their core market and one in which Apple, Google, and Facebook offer little competition. With loads of cash, a conucopia of brilliant personnel and Gates and Ballmer as the two largest shareholders, the whims of Wall Street bloggers don't have much effect.",
        children: [
          {
            username: "nl",
            time: "about 1 day ago",
            text: "Yes, Microsoft has a safe market in the enterprise.But in 2000 they still had a growing consumer market (remember Windows 95 was only 5 years ago). Now they are struggling to protect that consumer market, while markets they expected to dominate (remember when Windows Mobile + Exchange was supposed to kill off Blackberry?) have proven to be no only complete failures for Microsoft, but have become weaknesses through which other companies are pushing products into the Enterprise. Just about every CIO in the world said the iPhone would never be allowed in the enterprise, right up until their CEO demanded it. Then the same CIOs discovered they could sell using Google Mail in their enterprise as 'Oh, it's just the same as GMail', while cutting their costs hugely over Exchange. Then VMWare came along and allowed CTOs to run non-homogenous platforms in the datacenter, and do it much cheaper than the old way. Make no mistake: Microsoft makes good money and is still a force, but the last decade truly was a lost opportunity for them.",
            children: [
              {
                username: "brudgers",
                time: "about 23 hours ago",
                text: "In 2000, everyone had a growing consumer market because so many people were still buying their first computer. Today, Microsoft's competition in the enterprise market doesn't come from any of the companies people use as a basis for comparison when making allegations that Microsoft is stagnant, i.e. the enterprise competitors are companies like Red Hat and Oracle, not Google, Apple, and Facebook."
              },
              {
                username: "sseveran",
                time: "about 1 day ago",
                text: "GMail is not even close to a replacement for exchange in a large company. Small companies like mine can use it just fine but I can't see it working as well in a large company. In fact if I still had to write large quantities of mail (which I used to) I would still use outlook as a client as it has much more developed workflows and a richer set tools."
                children: [
                  {
                    username: "MattRogish",
                    time: "about 1 day ago",
                    text: "Outlook works just fine talking to Google Mail; our Windows users connect to Outlook. The rest of us Mac folks use Sparrow (which is not long for this world, unfortunately). Everyone has iPhones, which work great with Google Mail and Google Calendar. I'm exceptionally happy that, for most small and medium sized businesses, there's no need for anything other than Google Mail. I'm not entirely sure why 'Enterprises' would need Outlook, but I'll cede that's a market I don't know very well, so there may be very good reasons for it."
                  }
                ]
              }
            ]
          }
        ]
      },
      {
        username: "Graan",
        time: "about 6 hours ago",
        page: "Japanese equestrian defies Father Time as the oldest competitor at London Olympics - Yahoo! Sports",
        link: "http://sports.yahoo.com/news/olympics--japanese-equestrian-defies-father-time-as-oldest-competitor-at-london-olympics.html",
        domain: "sports.yahoo.com",
        srclevel: true,
        excerpt: "I have not seen my wife, Motoko, for more than a year",
        text: "The key to a long-lasting marriage",
        children: [
          {
            username: "buscat",
            time: "about 5 hours ago",
            text: "Apparently it's a problem in japanese families that the husband is away so often while he works that once he retires the wife can't deal with having him around all of a sudden. Dude took up the olympics just to stay away!",
            children: [
              {
                username: "kittehhh",
                time: "about 2 hours ago",
                text: "This isn't just a Japanese problem; one of my favorite professors once told me that he came out of retirement after teaching for forty years simply because he was afraid that he and his wife might divorce due to all of their new 'together' time."
                children: [
                  {
                    username: "Mule2go",
                    time: "about 1 hour ago"
                    text: "So true. Better or worse, but I don't remember agreeing to 24/7."
                  }
                ]
              },
              {
                username: "Torvaldr",
                time: "about 2 hours ago",
                text: "'He went out in the middle of the night for an Olympic Medal and never came home'"
              }
            ]
          },
          {
            username: "Baukeilen",
            time: "3 hours ago",
            text: "'After hanging up his business suit and briefcase, Hoketsu still had the itch to compete and entered the world of competitive dressage at his wife's insistence.' yep"
          }
        ]
      },
      {
        username: "jbellis",
        time: "about 1 hour ago",
        page: "German renewables output hits record high in H1 | Reuters",
        link: "http://www.reuters.com/article/2012/07/26/germany-renewables-idUSL6E8IQIA720120726",
        domain: "reuters.com",
        srclevel: true,
        excerpt: "Renewables now account for 25 percent of energy production, up from 21 percent last year, the country's energy industry association (BDEW) said in a statement that reinforced Germany's position as a leader in green technology.",
        text: "In related news, German electricity is 30% more expensive than French, and 300% more expensive than American.",
        children: [
          {
            username: "papaf",
            time: "about 3 minutes ago",
            text: "I don't think the purpose of going renewable is to save money -- it is more about energy security."
          },
          {
            username: "rayiner",
            time: "about 3 hours ago",
            text: "In related news: American electricity is artificially cheap."
          }
        ]
      }
    ]
  }