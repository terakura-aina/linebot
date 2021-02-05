document.addEventListener('DOMContentLoaded', () => {
  const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  const getProfileButton = document.querySelector(".getProfile")
  // 他のメソッドを実行できるようになるための作業
  liff.init({
    liffId: "1655592642-mxP7Mkkp"
  })
  .then(() => {
    if (!liff.isLoggedIn()) {
      liff.login();
    }
    // idTokenからユーザーIDを取得し、userテーブルに保存するための処理
    const idToken = liff.getIDToken()
    console.log(idToken)
    const body =`idToken=${idToken}`
    const request = new Request('/users', {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
        'X-CSRF-Token': token
      },
      method: 'POST',
      body: body
    });

  fetch(request)
  .then(response => response.json())
  .then(data => console.log(data))
  })
  .catch((err) => {
    console.log(err.code, err.message);
  });

  getProfileButton.addEventListener('click', () => {
    // フォームの内容をpostしてokが返ってきたらshareTargetPickerを開く
    const postFormElm = document.querySelector('#form')
    postFormElm.addEventListener('ajax:success', (e) => {
      console.log(e.detail[0])

      // ここでshared target pickerを呼び出す
      const redirect_url = `https://liff.line.me/1655592642-lkGjn55v/schedules/${e.detail[0].id}/edit`
      liff.shareTargetPicker([
        {
        'type': 'text',
        'text': 'デートのお誘いです'
        },
        {
        'type': 'text',
        'text': redirect_url
        }
      ]).then((res) => {
        if (res) {
          // TargetPickerが送られたら
          liff.closeWindow();
        } else {
          // TargetPickerを送らずに閉じたら
          console.log('TargetPicker was closed!')
          liff.closeWindow();
        }
      }).catch(function (res) {
        alert("失敗したよ")
      });
    })

       // make_planテーブルにinvited_idを保存するための処理
    // const req = new Request('/schedules/:schedule_id/make_plans', {
    //   headers: {
    //     'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
    //     'X-CSRF-Token': token
    //   },
    //   method: 'POST',
    //   body: body
    // });
    // fetch(req)
    // .then(response => response.json())
    // .then(data => console.log(data))
  })
})