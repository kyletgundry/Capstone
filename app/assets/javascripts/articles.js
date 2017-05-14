/* global Vue, $, salvattore, gon, moment */
document.addEventListener("DOMContentLoaded", function(event) {
  var app = new Vue({
    el: ".articles",
    data: {
      articles: [],
      sources: [],
      newFavoriteURL: "",
      toggleFavorite: false,
      articleTitleFilter: "",
      newSource: "",
      checkedSources: [],
      keywords: [],
      userKeywords: [],
      currentUser: gon.current_user,
      newKeyword: "",
      removedArticles: [],
      sortAttribute: "title",
      sortAscending: true
    },
    computed: {
      filteredArticles: function() {
        this.removedArticles = [];
        var testRun =  this.articles.filter(function(article) {
          var isValidSource = this.checkedSources.indexOf(article.source) !== -1;
          var isValidArticle = true;

          for (var i = 0; i < this.userKeywords.length; i++) {
            if (article.title.toLowerCase().indexOf(this.userKeywords[i].toLowerCase()) !== -1) {
              isValidArticle = false;
              this.removedArticles.push(article);
            }
          }
          var isValidSearch = article.title.toLowerCase().indexOf(this.articleTitleFilter.toLowerCase()) !== -1;

          return isValidSource && isValidArticle && isValidSearch;
        }.bind(this));
        
        var sorted = testRun.sort(function(article1, article2) {
          if (this.sortAscending) {
            return article1[this.sortAttribute].localeCompare(article2[this.sortAttribute]);
          } else {
            return article2[this.sortAttribute].localeCompare(article1[this.sortAttribute]);
          }
        }.bind(this));
        return sorted;
      }
    },
    mounted: function() {
      // var currentUser = gon.current_user;
      console.log("info:", gon.current_user);
      
      $.get("api/v1/articles", function(responseData) {
        this.articles = responseData;
        salvattore.recreateColumns(document.getElementById("fh5co-board"));
      }.bind(this));
      
      $.get("api/v1/sources", function(responseData) {
        this.sources = responseData;
        // this.checkedSources = ["cnn", "engadget", "fortune"];
        if (gon.current_user) {
          this.checkedSources = this.sources
            .filter(function(source) {
              return source.selected;
            })
            .map(function(source) {
              return source.source;
            });
        } else {
          this.checkedSources = this.sources
          .map(function(source) {
            return source.source;
          });
        }
      }.bind(this));
      
      if (gon.current_user) {
        $.get("api/v1/keywords", function(responseData) {
          this.keywords = responseData;
          console.log(this.keywords);
          this.userKeywords = this.keywords
          .filter(function(keyword) {
            return keyword.user_keyword;
          })
          .map(function(keyword) {
            return keyword.keyword;
          });
          console.log('here are the keywords', this.userKeywords);
        }.bind(this));
      }
    },
    methods: {
      toggleFavorited: function(inputArticle) {
        inputArticle.favorited = !inputArticle.favorited;
        console.log("Input Favorite: ", inputArticle);
        var params = {url: inputArticle.url};
        console.log("Favorite Article URL: ", params);
        if (inputArticle.favorited) {
          $.post("/api/v1/favorites", params, function(responseData) {
            this.favorites.push(responseData);
          }.bind(this));
        } else {
          $.post("/api/v1/favorites/delete", params, function(responseData) {
            this.favorites.push(responseData);
          });
        }
      },
      createSource: function(inputSource) { 
        console.log("InputSource: ", inputSource);
        var checkedSource = inputSource;
        var params = {source_id: checkedSource.id};
        if (checkedSource.selected === false) {
          $.post("/api/v1/usersources", params, function(responseData) {
            this.usersources.push(responseData);
          }.bind(this));
        } else {
          $.post("/api/v1/usersources/delete", params, function(responseData) {
          });
        }
      },
      moment: function(date) {
        return moment(date).format('MMMM Do YYYY, h:mm a');
      },
      setSortAttribute: function(inputAttribute) {
        if (inputAttribute === this.sortAttribute) {
          this.sortAscending = !this.sortAscending;
        } else {
          this.sortAscending = true;
        }
        this.sortAttribute = inputAttribute;
      }

      // createKeyword: function() { 
      //   var params = {keyword: this.newKeyword};
      //   console.log("keyword: ", params);
      //   $.post("/api/v1/keywords", params, function(responseData) {
      //     console.log(responseData);
      //     this.keywords.push(responseData);
      //     this.keywords.$forceUpdate();
      //     this.newKeyword = "";
      //   }.bind(this));
      // }
    }
  });
});
