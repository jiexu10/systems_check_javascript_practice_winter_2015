$('#dream_form').on("submit", function(event) {
  event.preventDefault();
  var newDream = $('#dream_description').val();
  if (newDream) {
    makeAjaxRequest(newDream);
  } else {
    alert('plz');
  }
});

var makeAjaxRequest = function(postData) {
  var request = $.ajax({
    method: "POST",
    data: { description: postData },
    url: "/dreams.json"
  });

  request.success(function() {
    $("#dreams").append("<li>" + postData + "</li>");
    $('#dream_description').val('');
  });
};
