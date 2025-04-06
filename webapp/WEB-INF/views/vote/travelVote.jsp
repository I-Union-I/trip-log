<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>������ ���� ������</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
        integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
        integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="reset.css" />
    <style>
        .vote-header {
            /* border: solid 2px black; */
            display: flex;
            flex-direction: column;
            margin: 2rem 0rem;
        }

        .title::before {
            content: "";
            background-color: var(--strong-color);
            color: var(--strong-color);
            padding: 0.25rem;
            margin-left: 0.9rem;
            margin: 0.5rem;
        }

        .title {
            width: 100%;
            /* border: solid 1px yellowgreen; */
            font-size: 2rem;
            font-weight: bold;
            padding: 1rem;
            margin: 0.5rem;
        }

        .vote-header-subtitle {
            width: 95%;
            /* border: solid 1px red; */
            display: flex;
            margin: auto;
        }

        .vote-body {
            /* border: solid 2px black; */
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .vote-lists {
            /* border: solid 1px green; */
            display: flex;
            justify-content: space-around;
            margin: 2rem;
            width: 100%;
        }

        .vote-list {
            /* border: solid 3px yellow; */
        }

        .vote-list-image {
            border-radius: 12px;
            /* border: solid 2px orange; */
            background-color: #e6e6e6;
            padding: 0.1rem;
            width: 10.5rem;
            height: 15rem;
        }

        .vote-list-image img {
            border-radius: 12px;
            display: block;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .vote-list-name {
            /* border: solid 2px blue; */
            margin-top: 0.3rem;
            display: flex;
            align-items: center;
            justify-content: space-around;
        }

        /* ����ִ� �� ũ��, �� ���� */
        .fa-regular.fa-circle {
            font-size: 2rem;
            color: var(--main-color);
        }

        /* üũ�Ǿ��ִ� �� ũ��, �� ���� */
        .fa-regular.fa-circle-check {
            font-size: 2rem;
            color: var(--main-color);
        }

        .vote-list-name label {
            border-radius: 15px;
            border: solid 2px var(--main-color);
            padding: 0.5rem 1rem;
            font-size: 1.3rem;
            font-weight: bold;
            display: flex;
            justify-content: space-around;
        }

        .vote-footer {
            /* border: solid 2px red; */
            width: 100%;
            display: flex;
            justify-content: flex-end;
            margin-bottom: 2rem;
        }

        .vote-btn {
            border-radius: 15px;
            border: solid 1px #BAD9CE;
            padding: 0.8rem 1.8rem;
            margin: 0.5rem;
            margin-right: 4%;
            color: white;
            background-color: #8AD9CE;
            font-size: 2rem;
            font-weight: 500;
        }

        .vote-btn:hover {
            border-radius: 15px;
            border: solid 1px var(--strong-color);
            padding: 0.8rem 1.8rem;
            margin: 0.5rem;
            margin-right: 4%;
            color: white;
            background-color: var(--strong-color);
            font-size: 2rem;
            font-weight: 500;
        }

        [type="radio"] {
            appearance: none;
            width: 1.5rem;
            height: 1.5rem;
            box-shadow: 0 0 0 3px var(--main-color);
            border-radius: 50%;
        }

        [type="radio"]:checked {
            appearance: none;
            width: 1.5rem;
            height: 1.5rem;
            border: 3px solid white;
            background-color: var(--main-color);
            border-radius: 50%;
        }
    </style>

</head>

<body>
    <div id="root">
        <div class="container">
            <div class="vote-header">
                <div class="vote-header-title">
                    <h2 class="title">�̹����� �츮 ���� ����?</h2>
                </div>
                <div class="vote-header-subtitle">
                    <h6>���� ������� �������� ����ּ���.</h6>
                </div>
            </div>
            <form action="vote/result.do" method="get">
                <div class="vote-body">
                    <div class="vote-lists">
                        <div class="vote-list">
                            <div class="vote-list-image">
                                <img src="image/����.png" alt="">
                            </div>
                            <div class="vote-list-name">
                                <!-- ����ִ� �� -->
                                <input type="radio" name="travle" id="����">
                                <label for="����">����</label>
                            </div>
                        </div>
                        <div class="vote-list">
                            <div class="vote-list-image">
                                <img src="image/����.png" alt="">
                            </div>
                            <div class="vote-list-name">
                                <!-- ����ִ� �� -->
                                <input type="radio" name="travle" id="����">
                                <label for="����">����</label>
                            </div>
                        </div>
                        <div class="vote-list">
                            <div class="vote-list-image">
                                <img src="image/����.png" alt="">
                            </div>
                            <div class="vote-list-name">
                                <!-- ����ִ� �� -->
                                <input type="radio" name="travle" id="����">
                                <label for="����">����</label>
                            </div>
                        </div>
                        <div class="vote-list">
                            <div class="vote-list-image">
                                <img src="image/����.png" alt="">
                            </div>
                            <div class="vote-list-name">
                                <!-- ����ִ� �� -->
                                <input type="radio" name="travle" id="����">
                                <label for="����">����</label>
                            </div>
                        </div>
                    </div>
                    <div class="vote-lists">
                        <div class="vote-list">
                            <div class="vote-list-image">
                                <img src="image/��õ.png" alt="">
                            </div>
                            <div class="vote-list-name">
                                <!-- ����ִ� �� -->
                                <input type="radio" name="travle" id="��õ">
                                <label for="��õ">��õ</label>
                            </div>
                        </div>
                        <div class="vote-list">
                            <div class="vote-list-image">
                                <img src="image/����.png" alt="">
                            </div>
                            <div class="vote-list-name">
                                <!-- ����ִ� �� -->
                                <input type="radio" name="travle" id="����">
                                <label for="����">����</label>
                            </div>
                        </div>
                        <div class="vote-list">
                            <div class="vote-list-image">
                                <img src="image/�λ�.png" alt="">
                            </div>
                            <div class="vote-list-name">
                                <!-- ����ִ� �� -->
                                <input type="radio" name="travle" id="�λ�">
                                <label for="�λ�">�λ�</label>
                            </div>
                        </div>
                        <div class="vote-list">
                            <div class="vote-list-image">
                                <img src="image/���ֵ�.png" alt="">
                            </div>
                            <div class="vote-list-name">
                                <!-- ����ִ� �� -->
                                <input type="radio" name="travle" id="���ֵ�">
                                <label for="���ֵ�">���ֵ�</label>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="vote-footer">
                    <button class="vote-btn">��ǥ�ϱ�</button>
                </div>
            </form>
        </div>
    </div>
</body>
<!-- 
1) ������ �߰��ϸ� ����**
2) üũ ĭ �ٽùٲٱ� input ���� (�����͸� DB�� �����ؾߵǱ� ������)
-->

</html>