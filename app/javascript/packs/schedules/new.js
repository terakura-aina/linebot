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
  })
  .catch((err) => {
    console.log(err.code, err.message);
  });

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

  getProfileButton.addEventListener('click', () => {

    // フォームの内容をpostしてokが返ってきたらshareTargetPickerを開く
    $('.form').on('ajax:success', (e) =>
    {
      const schedule_id = e

      // make_planテーブルにinvited_idを保存するための処理
    const req = new Request(`/schedules/${schedule_id}/make_plans`, {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
        'X-CSRF-Token': token
      },
      method: 'POST',
      body: body
    });
    fetch(req)
    .then(response => response.json())
    .then(data => console.log(data))
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