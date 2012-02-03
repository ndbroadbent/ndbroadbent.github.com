// Set Disqus to developer mode if developing site on localhost
if (window.location.href.indexOf("//localhost") != -1) {
  var disqus_developer = 1;
};

$(function() {
  $('.two-col, ul.site_links').noisy({
      'intensity' : 1,
      'size' : 200,
      'opacity' : 0.08,
      'fallback' : '',
      'monochrome' : false
  })

  // Open links from blog post content in a new tab/window
  $(".post .content a.new_tab").attr("target","_blank");

  $("#tweets").tweet({
    username: "nathanf77",
    join_text: "auto",
    avatar_size: 32,
    count: 3,
    auto_join_text_default: ":",
    auto_join_text_ed: ":",
    auto_join_text_ing: ":",
    auto_join_text_reply: "in reply to ",
    auto_join_text_url: ":",
    loading_text: "loading tweets..."
  });

  // Emulate Github's tooltip style
  jQuery.fn.qtip.styles.github = {
    background: '#555',
    color: 'white',
    tip: {
      corner: 'topMiddle',
      color: false,
      size: { x: 8, y: 5 }
    },
    border: {
      width:  3,
      radius: 3,
      color:  '#555'
    },
    padding: '0 4px'
  }


  // Auto-setup fancybox lightboxes / thumbnails for images.
  $("img.lightbox").each(function(i) {
    // For each image with the 'lightbox' class, the original image url
    // is replaced with the resized 'post' url.
    // The image is then wrapped in a link tag with the url of the original image,
    // which is then turned into a lightbox by fancybox.
    var large_url = $(this).attr('src');
    var resize_class = $(this).hasClass('thumb') ? "thumb" : "post"
    var resized_url = large_url.replace(/\.([a-z]*)$/, "-resized-" + resize_class + ".\$1");
    // Set the url for the original image to a resized version
    $(this).attr('src', resized_url);

    var link = $('<a href="'+large_url+'" />');
    link.attr('title', '(click to enlarge)');
    if ($(this).attr('alt')) { link.attr('title', $(this).attr('alt') + '   ' + link.attr('title')); }

    link.fancybox();
    $(this).wrap(link);
  });


  $('a[href][title]').each(function() {
    $(this).qtip({
      content: $(this).attr('title'),
      style: {name: 'github'},
      show: { delay: 0, effect: { length: 100 } },
      hide: { delay: 0, effect: { length: 100 } },
      position: {
        corner: {
           target: 'bottomMiddle',
           tooltip: 'topMiddle'
        }
      }
    });
    $(this).removeAttr('title');
  });

  $("#projects").each(function() {
    var featured_projects = {
      "actionmailer_inline_css": {rubygems: true},
      "ubuntu_config": {rubygems: false}
    };

    var Projects = {
      github_url: function(name) {
        return "https://api.github.com/repos/ndbroadbent/" + name;
      },
      rubygems_url: function(name) {
        return "https://rubygems.org/api/v1/gems/" + name + ".json";
      }
    }
    var urls = "";
    $.each(featured_projects, function(name, data) {
      urls = urls + "&urls[]=" + Projects.github_url(name)
      if(data['rubygems']) {
        urls = urls + "&urls[]=" + Projects.rubygems_url(name);
      }
    });
    $.getJSON("http://bulker.herokuapp.com/?a=1" + urls + "&callback=?", function(data) {
      $.each(data, function(url, response) {
        $.each(featured_projects, function (name, attributes) {
          if(url == Projects.github_url(name)) {
            featured_projects[name]["github_url"]  = response.body.html_url;
            featured_projects[name]["name"]        = response.body.name;
            featured_projects[name]["description"] = response.body.description;
            featured_projects[name]["watchers"]    = response.body.watchers;
            featured_projects[name]["forks"]       = response.body.forks;
          } else if(url == Projects.rubygems_url(name)) {
            featured_projects[name]["downloads"]    = response.body.downloads;
            featured_projects[name]["rubygems_url"] = response.body.project_uri;
          };
        });
      });
      var projectTemplate = $("#projectTemplate").template();
      $.each(featured_projects, function(name, attributes) {
        $.tmpl( projectTemplate, attributes ).appendTo( "#projects" );
      });
    });
  });
});

