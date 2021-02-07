debugger
document.addEventListener('DOMContentLoaded', () => {
  const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  const getProfileButton = document.querySelector("#getProfile")
  const sub_field = document.querySelector("#sub")
  // 他のメソッドを実行できるようになるための作業
  liff.init({
    liffId: "1655592642-lkGjn55v"
  })
  .then(() => {
    if (!liff.isLoggedIn()) {
      liff.login();
    }
  })
  .catch((err) => {
    console.log(err.code, err.message);
  });
})