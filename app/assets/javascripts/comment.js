$(function () {
  $(document).on("click", ".comment-cancel-button", function () {
    const commentId = $(this).data('cancel-id');
    const commentBody = $('#comment-body-' + commentId);
    const commentTextArea = $('#textarea-comment-' + commentId);
    const commentButton = $('#comment-button-' + commentId);

    commentBody.show();
    commentTextArea.hide();
    commentButton.hide();
  });
});


function clearTextarea() {
	var textareaForm = document.getElementById("comment-clear");
  textareaForm.value = '';
}