import { bootpay } from "./bootpay.js";

$(function () {
  reviewRegister();
  payment();
  heartBtn();
  productEditBtn();
  productDeleteBtn();
});
// 결제 API
const payment = async () => {
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
    Swal.fire({
      title: "상품 결제",
      icon: "question",
      text: `${productInfo.name} ${productInfo.price}원 상품을 구매하시겠습니까?`,
    }).then(async (result) => {
      if (result.isConfirmed) {
        try {
          const response = await Bootpay.requestPayment({
            application_id: bootpay.js_key,
            price: productInfo.price,
            order_name: productInfo.name,
            order_id: "TEST_ORDER_ID", // 실제로는 유니크하게 만들어야 함
            pg: "이니시스",
            method: "카드",
            tax_free: 0,
            user: {
              id: productInfo.memberId,
              username: "관리자",
              phone: "01000000000",
              email: "test@test.com",
            },
            items: [
              {
                id: productInfo.productId,
                name: productInfo.name,
                qty: 1,
                price: productInfo.price,
              },
            ],
            extra: {
              open_type: "iframe",
              card_quota: "0,2,3",
              escrow: false,
              separately_confirmed: true,
              display_error_result: true,
            },
          });

          // 결제 성공 시 서버로 결제 정보 전송
          $.ajax({
            url: "/trip-log/payment/confirm", // 서버에서 결제 처리할 엔드포인트
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify({
              receiptId: response.receipt_id,
              orderId: response.order_id,
              price: response.price,
              status: response.status,
              userId: productInfo.memberId,
              productId: productInfo.productId,
            }),
            success: function (result) {
              if (result.success) {
                Bootpay.destroy();
                Swal.fire("결제 성공", result.message, "success").then(() => {
                  location.href = "/trip-log/products/detail/" + productInfo.productId;
                });
              } else {
                Swal.fire("결제 실패", result.message, "warning");
                location.href = "/trip-log/products/detail/" + productInfo.productId;
              }
            },
            error: function (error) {
              Swal.fire("서버 오류", "결제 정보 저장 중 문제가 발생했습니다.", "error");
            },
          });
        } catch (error) {
          // Bootpay 결제 실패
          Swal.fire("결제 실패", error.message || "결제 중 문제가 발생했습니다.", "error");
        }
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
