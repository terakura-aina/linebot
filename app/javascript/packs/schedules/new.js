document.addEventListener('DOMContentLoaded', () => {
  const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  const getProfileButton = document.querySelector("#getProfile")
  // 他のメソッドを実行できるようになるための作業
  liff.init({
    liffId: "1655592642-mxP7Mkkp"
  })
  .then(() => {
    if (!liff.isLoggedIn()) {
      liff.login();
    }
  })
  .catch((err) => {
    console.log(err.code, err.message);
  });

  getProfileButton.addEventListener('click', () => {
    // idTokenからユーザーIDを取得する
    const idToken = liff.getIDToken()
    console.log(idToken)
    const body =`idToken=${idToken}`
    const request = new Request('/schedules', {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
        'X-CSRF-Token': token
      },
      method: 'POST',
      body: body
    });
    fetch(request)
    .then(response => response.json())
      .then(data => {
         console.log(data)
        });

    // フォームの内容をpostしてokが返ってきたらshareTargetPickerを開く
    const form = document.querySelector('.form')
    const data = new FormData(form)
    fetch('/schedules', {
      method: 'POST',
      body: data,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
      }
    })
    .then(response => response.json())
      .then(liff.shareTargetPicker([
        {
        'type': 'text',
        'text': 'デートのお誘いです'
        },
        {
        'type': 'text',
        'text': 'schedules#showページのURL'
        }
      ]))
    .catch(error => {
      console.log('失敗しました')
    })
  })
})