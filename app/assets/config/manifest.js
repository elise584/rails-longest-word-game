//= link_tree ../images
//= link_directory ../stylesheets .css

fetch("http://www.omdbapi.com/?s=harry potter&apikey=adf1f2d7")
  .then(response => response.json())
  .then((data) => {
    console.log(data);
  });
