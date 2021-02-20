document.addEventListener('DOMContentLoaded', () => {
  const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  // 他のメソッドを実行できるようになるための作業
  liff.init({
    liffId: "11655592642-mxP7Mkkp"
  })
  .then(() => {
    if (!liff.isLoggedIn()) {
      liff.login();
    }
  })
})

$(function () {
  $('.btn').on('click', function () {
      if ($(this).text() === '完了') {
          $(this).text('未完了');
      } else {
          $(this).text('完了');
      }
  });
});