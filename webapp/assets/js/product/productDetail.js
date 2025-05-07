// onload = function() {
//     reviewRegister();
// }

// // 결제 API
// const payment = () => {
//     const paymentBtn = document.getElementById("paymentBtn");

//     paymentBtn.addEventListener("click", () => {

//     })
// }

// // 리뷰 등록
// const reviewRegister = () => {
//     const rateWrap = document.querySelectorAll('.rating'),
//         label = document.querySelectorAll('.rating .rating__label'),
//         input = document.querySelectorAll('.rating .rating__input'),
//         labelLength = label.length,
//         opacityHover = '0.5';

//     let stars = document.querySelectorAll('.rating .star-icon');

//     checkedRate();

//     rateWrap.forEach(wrap => {
//         wrap.addEventListener('mouseenter', () => {
//             stars = wrap.querySelectorAll('.star-icon');

//             stars.forEach((starIcon, idx) => {
//                 starIcon.addEventListener('mouseenter', () => {
//                     initStars();
//                     filledRate(idx, labelLength);

//                     for (let i = 0; i < stars.length; i++) {
//                         if (stars[i].classList.contains('filled')) {
//                             stars[i].style.opacity = opacityHover;
//                         }
//                     }
//                 });

//                 starIcon.addEventListener('mouseleave', () => {
//                     starIcon.style.opacity = '1';
//                     checkedRate();
//                 });

//                 wrap.addEventListener('mouseleave', () => {
//                     starIcon.style.opacity = '1';
//                 });
//             });
//         });
//     });

//     function filledRate(index, length) {
//         if (index <= length) {
//             for (let i = 0; i <= index; i++) {
//                 stars[i].classList.add('filled');
//             }
//         }
//     }

//     function checkedRate() {
//         let checkedRadio = document.querySelectorAll('.rating input[type="radio"]:checked');

//         initStars();
//         checkedRadio.forEach(radio => {
//             let previousSiblings = prevAll(radio);

//             for (let i = 0; i < previousSiblings.length; i++) {
//                 previousSiblings[i].querySelector('.star-icon').classList.add('filled');
//             }

//             radio.nextElementSibling.classList.add('filled');

//             function prevAll() {
//                 let radioSiblings = [],
//                     prevSibling = radio.parentElement.previousElementSibling;

//                 while (prevSibling) {
//                     radioSiblings.push(prevSibling);
//                     prevSibling = prevSibling.previousElementSibling;
//                 }
//                 return radioSiblings;
//             }
//         });
//     }

//     function initStars() {
//         for (let i = 0; i < stars.length; i++) {
//             stars[i].classList.remove('filled');
//         }
//     }

//     const reviewRegisterBtn = document.getElementById("reviewRegisterBtn");

//     reviewRegisterBtn.onclick = () => {
//         let starInputArr = document.querySelectorAll(".star-icon.filled");
//         console.log(starInputArr.length / 2);
//     }
// }
$(function () {
  reviewRegister();
  payment();
  heartBtn();
  productEditBtn();
  productDeleteBtn();
});
// 결제 API
const payment = () => {
  const $paymentBtn = $("#paymentBtn");

  console.log(productInfo);

  console.log("상품 ID : " + productInfo.productId);
  console.log("상품 이름 : " + productInfo.name);
  console.log("회원 ID : " + productInfo.memberId);
  console.log("상품 가격 : " + productInfo.price);

  /*
    $paymentBtn.on("click", $.ajax({
        // 결제 API
    }));
    */

  $paymentBtn.on("click", () => {
    // Swal.fire({
    //   title: "상품 결제",
    //   icon: "warning",
    //   text: "아직 개발 중 입니다...ㅠ",
    // });
    Swal.fire({
      title: "상품 결제",
      icon: "question",
      text: `${productInfo.name} - ${productInfo.price} 상품을 구매하시겠습니까?`,
    }).then(async (result) => {
      if (result.isConfirmed) {
        const response = await Bootpay.requestPayment({
          application_id: "59a4d323396fa607cbe75de4",
          price: 1000,
          order_name: "테스트결제",
          order_id: "TEST_ORDER_ID",
          pg: "다날",
          method: "카드",
          tax_free: 0,
          user: {
            id: "회원아이디",
            username: "회원이름",
            phone: "01000000000",
            email: "test@test.com",
          },
          items: [
            {
              id: "item_id",
              name: "테스트아이템",
              qty: 1,
              price: 1000,
            },
          ],
          extra: {
            open_type: "iframe",
            card_quota: "0,2,3",
            escrow: false,
          },
        });
      }
    });
  });
};

// 리뷰 등록
const reviewRegister = () => {
  const $rateWrap = $(".rating"),
    $label = $(".rating .rating__label"),
    $input = $(".rating .rating__input"),
    labelLength = $label.length,
    opacityHover = "0.5";

  let $stars = $(".rating .star-icon");

  checkedRate();

  $rateWrap.each(function () {
    const $wrap = $(this);

    $wrap.on("mouseenter", function () {
      $stars = $wrap.find(".star-icon");

      $stars.each(function (idx) {
        const $starIcon = $(this);

        $starIcon.on("mouseenter", function () {
          initStars();
          filledRate(idx, labelLength);

          $stars.each(function () {
            const $star = $(this);
            if ($star.hasClass("filled")) {
              $star.css("opacity", opacityHover);
            }
          });
        });

        $starIcon.on("mouseleave", function () {
          $starIcon.css("opacity", "1");
          checkedRate();
        });

        $wrap.on("mouseleave", function () {
          $starIcon.css("opacity", "1");
        });
      });
    });
  });

  function filledRate(index, length) {
    if (index <= length) {
      for (let i = 0; i <= index; i++) {
        $stars.eq(i).addClass("filled");
      }
    }
  }

  function checkedRate() {
    const $checkedRadio = $('.rating input[type="radio"]:checked');

    initStars();

    $checkedRadio.each(function () {
      const $radio = $(this);
      const $previousSiblings = prevAll($radio);

      $previousSiblings.each(function () {
        $(this).find(".star-icon").addClass("filled");
      });

      $radio.next().addClass("filled");

      function prevAll($el) {
        const $siblings = [];
        let $prev = $el.parent().prev();

        while ($prev.length) {
          $siblings.push($prev[0]);
          $prev = $prev.prev();
        }

        return $($siblings);
      }
    });
  }

  function initStars() {
    $stars.removeClass("filled");
  }

  const $reviewRegisterBtn = $("#reviewRegisterBtn");

  $reviewRegisterBtn.on("click", function () {
    const $starInputArr = $(".star-icon.filled");
    console.log($starInputArr.length / 2);
    const score = $starInputArr.length / 2;

    // 리뷰 등록
    $.ajax({
      url: "/trip-log/products/review/" + productInfo.productId,
      method: "post",
      data: {
        memberId: productInfo.memberId,
        score: score,
      },
      success: (data) => {
        // console.log("통신 성공");
        console.log(data);
        Swal.fire({
          title: data.title,
          icon: data.icon,
          text: data.text,
        }).then((result) => {
          if (result.isConfirmed) {
            // 리뷰 등록 후 reload
            location.reload(true);
          }
        });
      },
      error: () => {
        Swal.fire({
          title: "리뷰 등록",
          icon: "error",
          text: "리뷰 등록 오류",
          confirmButtonText: "확인",
        }).then((result) => {
          if (result.isConfirmed) {
            location.href = "/trip-log/products/detail/" + productInfo.productId;
          }
        });
      },
    });
  });
};

const productEditBtn = () => {
  $(".product-edit-icon").click(() => {
    Swal.fire({
      title: "상품 수정",
      icon: "question",
      text: "상품을 수정하시겠습니까?",
      confirmButtonColor: "#118C8C",
      confirmButtonText: "수정",
      confirmTextColor: "#FFF",
      showCancelButton: true,
      cancelButtonText: "취소",
    }).then((result) => {
      if (result.isConfirmed) {
        // console.log(productInfo.productId);
        location.href = "/trip-log/products/update/" + productInfo.productId;
      }
    });
  });
};

const productDeleteBtn = () => {
  $(".product-trash-icon").click(() => {
    // console.log("click");
    Swal.fire({
      title: "상품 삭제",
      icon: "question",
      text: "상품을 삭제하시겠습니까?",
      confirmButtonColor: "#F00",
      confirmButtonText: "삭제",
      showCancelButton: true,
      cancelButtonText: "취소",
    }).then((result) => {
      if (result.isConfirmed) {
        // console.log(productInfo.productId);
        location.href = "/trip-log/products/auth/delete/" + productInfo.productId;
      }
    });
  });
};

const heartBtn = () => {
  $("#heartBtn").click((e) => {
    const $icon = $(e.currentTarget).find("i"); // i 태그 선택

    if (!$icon.hasClass("heart-active")) {
      // 상품 찜 안했을 경우
      Swal.fire({
        title: "찜 하기",
        icon: "question",
        text: "상품을 찜 하시겠습니까?",
        confirmButtonColor: "#118C8C",
        confirmButtonText: "찜",
        showCancelButton: true,
        cancelButtonText: "취소",
      }).then((result) => {
        if (result.isConfirmed) {
          $.ajax({
            url: "/trip-log/products/auth/favorite",
            method: "post",
            data: {
              productId: productInfo.productId,
              memberId: productInfo.memberId,
            },
            success: (data) => {
              // console.log(data);
              Swal.fire({
                title: data.title,
                icon: data.icon,
                text: data.text,
              }).then((result) => {
                if (result.isConfirmed) {
                  location.reload(true);
                }
              });
              $icon.addClass("heart-active");
            },
            error: (error) => {
              Swal.fire({
                title: "찜 하기",
                icon: "error",
                text: "찜 하기 오류",
                confirmButtonText: "확인",
              }).then((result) => {
                if (result.isConfirmed) {
                  console.log("error : " + error);
                  location.href = "/trip-log/products/detail/" + productInfo.productId;
                }
              });
            },
          });
        }
      });
    } else {
      // 상품 찜 했을 경우
      Swal.fire({
        title: "찜 취소",
        icon: "question",
        text: "상품 찜을 취소하시겠습니까?",
        confirmButtonColor: "$colorValue",
        confirmButtonText: "찜 취소",
        showCancelButton: true,
        cancelButtonText: "취소",
      }).then((result) => {
        if (result.isConfirmed) {
          $.ajax({
            url: "/trip-log/products/auth/delete/favorite",
            method: "post",
            data: {
              productId: productInfo.productId,
              memberId: productInfo.memberId,
            },
            success: (data) => {
              // console.log(data);
              Swal.fire({
                title: data.title,
                icon: data.icon,
                text: data.text,
              }).then((result) => {
                if (result.isConfirmed) {
                  location.reload(true);
                }
              });
              $icon.removeClass("heart-active");
            },
            error: (error) => {
              Swal.fire({
                title: "찜 취소",
                icon: "error",
                text: "찜 취소 오류",
                confirmButtonText: "확인",
              }).then((result) => {
                if (result.isConfirmed) {
                  console.log("error : " + error);
                  location.href = "/trip-log/products/detail/" + productInfo.productId;
                }
              });
            },
          });
        }
      });
    }
  });
};
