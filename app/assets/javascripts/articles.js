/* global Vue, $ */
document.addEventListener("DOMContentLoaded", function(event) {
  var app = new Vue({
    el: ".articles",
    data: {
      articles: [],
      sources: [],
      newFavoriteURL: "",
      sourceFilter: "",
      checkedSources: []
    },
    computed: {
      filteredArticles: function() {
        return this.articles.filter(function(article) {
          return this.checkedSources.indexOf(article.source) !== -1;
        }.bind(this));
      },
      filteredSources: function() {
        var sourceFilter = this.sourceFilter;
        var filtered = this.sources.filter(function(source) {
          var sourceName = source.source;
          return sourceName.index(sourceFilter) !== 1;
        });
        return filtered;
      }
    },
    mounted: function() {
      $.get("api/v1/articles", function(responseData) {
        this.articles = responseData;
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
        });
      }
    }
  });
});
