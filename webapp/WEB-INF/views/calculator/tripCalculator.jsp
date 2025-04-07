<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR" isELIgnored="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String rootPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>������ ���� ������</title>

<%--
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
	integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
	integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="<%=rootPath%>/assets/css/reset.css" />
 --%>
<link rel="stylesheet"
	href="<%=rootPath%>/assets/css/calculator/tripCalculator.css" />

</head>

<body>
	<div id="root">
		<jsp:include page="../common/header.jsp"></jsp:include>
		<div class="container">
			<div class="calculator-header">
				<h2 class="title">������ ���� (����)</h2>
			</div>
			<div class="calculator-body">
				<div class="calculator-body-first">
					<div class="calculator-tabs">
						<div class="tabs">
							<div class="tab active" data-target="���ں�">���ں�</div>
							<div class="tab" data-target="�ĺ�">�ĺ�</div>
							<div class="tab" data-target="�����">�����</div>
							<div class="tab" data-target="�����">�����</div>
							<div class="tab" data-target="����">����(��Ÿ)</div>
						</div>
						<!-- ī�װ� ���ÿ� ���� �ٲ�°� ��� �ٲ�°� �� �� 
                        display:flex�ְ�, justify-content:space-between�� css���� => �ذ��� -->
						<!-- ���ں� ����Ʈ -->
						<div class="cost-list active" id="���ں�">
							<button class="add-btn">+</button>
							<div class="cost-items"></div>
							<!-- <div class="cost-item">
                            <input type="text" class="content" placeholder="�޸� �Է��ϼ���.">
                            <input type="number" class="price" placeholder="�ݾ�">
                        	</div> -->
						</div>

						<!-- �ĺ� ����Ʈ -->
						<div class="cost-list" id="�ĺ�">
							<button class="add-btn">+</button>
							<div class="cost-items"></div>
							<!-- <div class="cost-item">
                            <input type="text" class="content" placeholder="�޸� �Է��ϼ���.">
                            <input type="number" class="price" placeholder="�ݾ�">
                        </div> -->
						</div>

						<!-- ����� ����Ʈ -->
						<div class="cost-list" id="�����">
							<button class="add-btn">+</button>
							<div class="cost-items"></div>
							<!-- <div class="cost-item">
                            <input type="text" class="content" placeholder="�޸� �Է��ϼ���.">
                            <input type="number" class="price" placeholder="�ݾ�">
                        </div> -->
						</div>

						<!-- ����� ����Ʈ -->
						<div class="cost-list" id="�����">
							<button class="add-btn">+</button>
							<div class="cost-items"></div>
							<!-- <div class="cost-item">
                            <input type="text" class="content" placeholder="�޸� �Է��ϼ���.">
                            <input type="number" class="price" placeholder="�ݾ�">
                        </div> -->
						</div>

						<!-- ����(��Ÿ) ����Ʈ -->
						<div class="cost-list" id="����">
							<button class="add-btn">+</button>
							<div class="cost-items"></div>
							<!-- <div class="cost-item">
                            <input type="text" class="content" placeholder="�޸� �Է��ϼ���.">
                            <input type="number" class="price" placeholder="�ݾ�">
                        </div> -->
						</div>
					</div>
					<div class="cost-lists">
						<div class="calculator-price">
							<div id="totalPrice">
								�� �ݾ� : <span>��...</span> ��
							</div>
							<div id="duchPrice">
								1/N �ݾ� : <span>��...</span> ��
							</div>
						</div>
						<div class="submit">
							<button>�����ϱ�</button>
						</div>
					</div>
				</div>
				<div class="calculator-body-second">
					<div class="people-count">
						<span>�ο���</span>
						<div class="button">
							<i class="fa-solid fa-circle-minus" id="downBtn"></i> <span
								class="count" id="count">1</span> <i
								class="fa-solid fa-circle-plus" id="upBtn"></i>
						</div>
					</div>

					<div class="calculator-graph">
						<div class="donut-graph">
							<div class="graph">
								<svg width="200" height="200" viewBox="0 0 42 42" class="donut">
                                    <!-- ��� �� -->
                                    <circle class="donut-ring" cx="21"
										cy="21" r="15.9155" fill="transparent" stroke="#eee"
										stroke-width="7"></circle>

                                    <!-- ���� �׷��� ���� -->
                                    <!-- �ĺ� -->
                                    <circle class="donut-segment"
										id="food" cx="21" cy="21" r="15.9155" fill="transparent"
										stroke="#09F" stroke-width="7" stroke-dasharray="0 0"
										stroke-dashoffset="0"></circle>

                                    <!-- ����(��Ÿ) -->
                                    <circle class="donut-segment"
										id="etc" cx="21" cy="21" r="15.9155" fill="transparent"
										stroke="#e74c3c" stroke-width="7" stroke-dasharray=""
										stroke-dashoffset=""></circle>

                                    <!-- ����� -->
                                    <circle class="donut-segment"
										id="ticket" cx="21" cy="21" r="15.9155" fill="transparent"
										stroke="#2ecc71" stroke-width="7" stroke-dasharray=""
										stroke-dashoffset=""></circle>

                                    <!-- ����� -->
                                    <circle class="donut-segment"
										id="bus" cx="21" cy="21" r="15.9155" fill="transparent"
										stroke="#E8C1A0" stroke-width="7" stroke-dasharray=""
										stroke-dashoffset=""></circle>

                                    <!-- ���ں� -->
                                    <circle class="donut-segment"
										id="lodging" cx="21" cy="21" r="15.9155" fill="transparent"
										stroke="#f39c12" stroke-width="7" stroke-dasharray=""
										stroke-dashoffset=""></circle>

                                    <!-- �߾� �ؽ�Ʈ -->
                                    <text x="50%" y="50%"
										dominant-baseline="middle" text-anchor="middle" font-size="4"
										fill="#333">�� �ݾ�</text>
                                </svg>
								<div class="color-explanation">
									<li id="lodging-label" style="color: #f39c12;">���ں� : <span>%</span></li>
									<li id="food-label" style="color: #09F;">�ĺ� : <span>%</span></li>
									<li id="bus-label" style="color: #E8C1A0;">����� : <span>%</span></li>
									<li id="ticket-label" style="color: #2ecc71;">����� : <span>%</span></li>
									<li id="etc-label" style="color: #e74c3c;">����(��Ÿ) : <span>%</span></li>
								</div>
							</div>
						</div>
						<div class="percentage-explanation">
							<ul>
								<i class="fa-solid fa-tents">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���ں�
									: &nbsp; <span></span>��
								</i>
								<i class="fa-solid fa-utensils">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ĺ�
									: &nbsp; <span></span>��
								</i>
								<i class="fa-solid fa-van-shuttle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�����
									: &nbsp; <span></span>��
								</i>
								<i class="fa-solid fa-ticket">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�����
									: &nbsp; <span></span>��
								</i>
								<i class="fa-solid fa-suitcase-rolling">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����(��Ÿ)
									: &nbsp; <span></span>��
								</i>
							</ul>
							&nbsp;
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../common/footer.jsp"></jsp:include>
	</div>
				<script>
                // ��� �ǰ� ��� �Է� ����Ʈ ��������
                const tabs = document.querySelectorAll(".tab");
                const costLists = document.querySelectorAll(".cost-list");

                tabs.forEach(tab => {
                    tab.addEventListener("click", () => {
                        // ��� �ǿ��� active Ŭ���� ����
                        tabs.forEach(t => t.classList.remove("active"));
                        tab.classList.add("active");

                        // ��� ��� ����Ʈ �����
                        costLists.forEach(list => list.classList.remove("active"));

                        // Ŭ���� �ǿ� �ش��ϴ� ����Ʈ ���̱�
                        const targetId = tab.getAttribute("data-target");
                        document.getElementById(targetId).classList.add("active");
                        console.log(targetId);
                    });
                });

                // �߰� ��ư�� ������ ��� �Է� ����Ʈ �߰��ϱ�
                document.querySelectorAll(".add-btn").forEach(button => {
                    // Ƚ�������� �α� ���� ����
                    let count = 0;
                    button.addEventListener("click", (event) => {
                        if (count < 6) {

                            // ���� Ŭ���� ��ư�� ���� cost-list ã��
                            const parentCostList = event.target.closest(".cost-list");

                            // �ٹٲ� �߰�
                            // const newline = document.createElement("br");
                            // parentCostList.appendChild(newline);

                            // ���ο� ��� �Է� �׸� ����
                            const newCostItem = document.createElement("div");
                            newCostItem.classList.add("cost-item");
                            const costItems = document.querySelector(".cost-items");

                            // �� input ��ҵ� �߰�
                            const newContentInput = document.createElement("input");
                            newContentInput.type = "text";
                            newContentInput.classList.add("content");
                            newContentInput.placeholder = "�޸� �Է��ϼ���.";

                            const newPriceInput = document.createElement("input");
                            newPriceInput.type = "number";
                            newPriceInput.classList.add("price");
                            newPriceInput.placeholder = "�ݾ�";

                            // ���� ��ư �߰�
                            const deleteBtn = document.createElement("i");
                            deleteBtn.classList.add("fa-solid");
                            deleteBtn.classList.add("fa-trash");
                            deleteBtn.classList.add("delete-icon");
                            deleteBtn.addEventListener("click", () => {
                                newCostItem.remove();
                                // ������ư�� ������ ��� count ���̱�
                                count--;
                                console.log(count);
                                calculateTotal(); // �Ѿ� �ٽ� ���
                            });


                            // �� img �±� �߰�

                            // ��ҵ��� cost-item�� �߰�
                            newCostItem.appendChild(newContentInput);
                            newCostItem.appendChild(newPriceInput);
                            newCostItem.appendChild(deleteBtn);
                            // deleteBtn.src="image/delete-btn.png";

                            // cost-list�� �߰�
                            parentCostList.appendChild(newCostItem);
                            // �߰���ư�� ������ ��� count �ø���
                            count++;
                            console.log(count);
                        };
                    });
                });




                // �ο��� ���� ���
                const downBtn = document.getElementById("downBtn");
                const upBtn = document.getElementById("upBtn");
                const count = document.getElementById("count");

                let peopleCount = 0;    // �⺻�� 0

                downBtn.addEventListener("click", () => {
                    if (peopleCount > 1) {
                        peopleCount--;
                        count.textContent = peopleCount;
                    }
                });

                upBtn.addEventListener("click", () => {
                    peopleCount++;
                    count.textContent = peopleCount;
                });

                // ���� ���

                function calculateTotal() {
                    let total = 0;
                    document.querySelectorAll('.price').forEach(input => {
                        const value = parseInt(input.value) || 0;
                        total += value;
                    });

                    document.querySelector('#totalPrice span').innerText = total.toLocaleString();

                    const peopleCount = parseInt(document.querySelector('#count').innerText) || 1;
                    const duchPrice = Math.round(total / peopleCount);
                    document.querySelector('#duchPrice span').innerText = duchPrice.toLocaleString();


                }


                // ���� �ԷµǾ��� ���� ���տ� �ݿ�
                document.addEventListener('input', (e) => {
                    if (e.target.classList.contains('price')) {
                        calculateTotal();
                    }
                });

                document.addEventListener("click", (e) => {
                    if (e.target.classList.contains('fa-solid')) {
                        calculateTotal();
                    }
                });


                // �� ī�װ� �� �� �ݾ� ���
                function getCategoryTotals() {
                    const totals = [];
                    const costLists = document.querySelectorAll(".cost-list");

                    costLists.forEach(list => {
                        let categoryTotal = 0;
                        const prices = list.querySelectorAll(".price");

                        prices.forEach(priceInput => {
                            const value = parseInt(priceInput.value) || 0;
                            categoryTotal += value;
                        });

                        totals.push(categoryTotal);
                    });

                    console.log("totals : " + totals);
                    return totals;
                }
                // �� �ݾ��� ������ �ٲٱ�
                // const totals = getCategoryTotals();
                // const overallTotal = totals.reduce((a, b) => a + b, 0);
                // const percentages = totals.map(t => Math.round((t / overallTotal) * 100));

                const submitBtn = document.querySelector(".submit");
                submitBtn.addEventListener("click", () => {
                    const totals = getCategoryTotals();
                    const overallTotal = totals.reduce((a, b) => a + b, 0);


                    // 0~3�������� round�ؼ� �̸� ����
                    let percentages = totals.map(t => Math.round((t / overallTotal) * 100));
                    let sum = percentages.slice(0, 4).reduce((a, b) => a + b, 0);
                    percentages[4] = 100 - sum;  // ������ ��Ҵ� �����ؼ� 100% ���߱�
                    console.log("�Фü������� : " + percentages);
                    console.log("�Фü������� : " + percentages[0], typeof (percentages[0]));

                    // console.log("totals : " + totals);
                    // console.log("overallTotal : " + overallTotal);
                    document.querySelector('.donut text').textContent = overallTotal.toLocaleString() + "��";

                    const secondCircle = document.getElementById("food");
                    secondCircle.setAttribute('stroke-dasharray', `${percentages[1]} ${100 - percentages[1]}`);

                    const fiveCircle = document.getElementById("etc");
                    fiveCircle.setAttribute('stroke-dasharray', `${percentages[4]} ${100 - percentages[4]}`);
                    fiveCircle.setAttribute('stroke-dashoffset', `${-percentages[1]}`);

                    const fourCircle = document.getElementById("ticket");
                    fourCircle.setAttribute('stroke-dasharray', `${percentages[3]} ${100 - percentages[3]}`);
                    fourCircle.setAttribute('stroke-dashoffset', `${-(percentages[4] + percentages[1])}`);

                    const thirdCircle = document.getElementById("bus");
                    thirdCircle.setAttribute('stroke-dasharray', `${percentages[2]} ${100 - percentages[2]}`);
                    thirdCircle.setAttribute('stroke-dashoffset', `${-(percentages[4] + percentages[1] + percentages[3])}`);
                    console.log(-(percentages[0] + percentages[1]));

                    console.log(typeof (-(percentages[0] + percentages[1])));
                    const firstCircle = document.getElementById("lodging");
                    firstCircle.setAttribute('stroke-dasharray', `${percentages[0]} ${100 - percentages[0]}`);
                    firstCircle.setAttribute('stroke-dashoffset', `${-(percentages[4] + percentages[1] + percentages[2] + percentages[3])}`);
                    console.log(typeof (percentages[0]));

                    // ���� ���� ���� ������ ǥ��
                    const categoryIds = [
                        "lodging-label",
                        "food-label",
                        "bus-label",
                        "ticket-label",
                        "etc-label"
                    ];

                    percentages.forEach((percent, idx) => {
                        const span = document.querySelector("#" + categoryIds[idx] + " span");
                        // EL�� �νĵǴ°� ���Ƽ� �ٽ� ���� ����
                        span.textContent = percent + "%";
                    });

                    // �׷��� ���� ī�װ��� �ݾ��� ǥ��
                    // totals => [���ں�, �ĺ�, �����, �����, ��Ÿ]

                    document.querySelector('.fa-tents span').textContent = totals[0].toLocaleString();
                    document.querySelector('.fa-utensils span').textContent = totals[1].toLocaleString();
                    document.querySelector('.fa-van-shuttle span').textContent = totals[2].toLocaleString();
                    document.querySelector('.fa-ticket span').textContent = totals[3].toLocaleString();
                    document.querySelector('.fa-suitcase-rolling span').textContent = totals[4].toLocaleString();

                });



            </script>
</body>

</html>