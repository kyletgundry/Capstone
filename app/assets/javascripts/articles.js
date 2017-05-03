/* global Vue, $, salvattore */
document.addEventListener("DOMContentLoaded", function(event) {
  var app = new Vue({
    el: ".articles",
    data: {
      articles: [],
      sources: [],
      newFavoriteURL: "",
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
      createFavorite: function(inputArticle) {
        this.newFavoriteURL = inputArticle;
        var params = {url: this.newFavoriteURL};
        $.post("/api/v1/favorites", params, function(responseData) {
          console.log("Data: ", responseData);
          this.favorites.push(responseData);
        }.bind(this));
      },
      createSource: function(inputSource) {
        this.newSource = inputSource;
        var params = {source_id: this.newSource};
        $.post("/api/v1/usersources", params, function(responseData) {
          this.usersources.push(responseData);
        }.bind(this));
      }
    }
  });
});
