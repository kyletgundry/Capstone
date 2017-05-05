/* global Vue, $, salvattore */
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
      checkedSources: []
    },
    computed: {
      filteredArticles: function() {
        return this.articles.filter(function(article) {
          return this.checkedSources.indexOf(article.source) !== -1 && article.title.toLowerCase().indexOf(this.articleTitleFilter.toLowerCase()) !== -1;
        }.bind(this));
      }
    },
    mounted: function() {
      $.get("api/v1/articles", function(responseData) {
        this.articles = responseData;
        salvattore.recreateColumns(document.getElementById("fh5co-board"));
      }.bind(this));
      $.get("api/v1/sources", function(responseData) {
        this.sources = responseData;
        // this.checkedSources = ["cnn", "engadget", "fortune"];

        this.checkedSources = this.sources
          .filter(function(source) {
            return source.selected;
          }).map(function(source) {
            return source.source;
          });

      }.bind(this));
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

      // createFavorite: function(inputArticle) {
      //   this.newFavoriteURL = inputArticle;
      //   var params = {url: this.newFavoriteURL};
      //   $.post("/api/v1/favorites", params, function(responseData) {
      //     console.log("Data: ", responseData);
      //     this.favorites.push(responseData);
      //   }.bind(this));
      },
      // createSource: function(inputSource) {
      //   this.newSource = inputSource;
      //   var params = {source_id: this.newSource};
      //   $.post("/api/v1/usersources", params, function(responseData) {
      //     this.usersources.push(responseData);
      //   }.bind(this));
      // }
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
      }
    }
  });
});
