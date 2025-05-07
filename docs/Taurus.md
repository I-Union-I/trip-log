# 임성준(상품 기능 개발)
## 상품 주요 기능
- **[상품기능](#상품-기능)**
    - [상품 등록 코드](#productregisterconstructorjava)
    - [상품 아이디 경로에서 추출 메서드](#productpathjava)
- **[상품 검색, 정렬 및 페이징 처리](#상품-검색-상품-정렬-기능-및-페이징-처리)**
    - [상품 목록 코드](#productlistpagecontrollerjava)
- **[상품 찜 기능](#상품-찜-기능)**
    - [상품 찜 등록 코드](#productfavoriteregistercontrollerjava)
- **[상품 리뷰 기능](#상품-리뷰-기능)**
    - [상품 리뷰 등록 코드](#productreviewcontrollerjava)

### 상품 기능

- 관리자만 상품을 등록할 수 있습니다.
- 상품 목록 화면에서 우측 상단에 위치한 등록 아이콘을 통해 상품 등록 화면으로 이동할 수 있습니다.

> 관리자가 등록하는 상품 데이터 정보

- 상품 명
- 여행 대상 국가명
- 상품 이미지
    - 데이터베이스에는 이미지 원본 명과 수정 된 명으로 나눠서 저장 됩니다.
- 상품 재고
- 상품 가격
- 상품 설명

> 관리자가 등록 하지 않고 자동으로 등록 되는 상품 데이터 정보

- 상품 번호
- 관리자 번호
- 등록 날짜

> 상품 등록 기능 주요 코드

##### ProductRegisterConstructor.java
```java
@WebServlet("/products/auth/register")
@MultipartConfig(
		fileSizeThreshold = 1024 * 1024 * 1,
		maxFileSize = 1024 * 1024 * 10,
		maxRequestSize = 1024 * 1024 * 15
)
```
- `fileSizeThreshold = 1024 * 1024 * 1`
    - 이 크기가 넘으면 디스크의 임시디렉터리에 저장됩니다
    - 기본값은 0이므로 기본값일 경우 무조건 임시 디렉터리에 저장됩니다.
- `maxFileSize = 1024 * 1024 * 10`
    - 파일의 최대 크기입니다.
    - 기본값은 -1L이므로 제한이 없습니다.
- `maxRequestSize = 1024 * 1024 * 15`
    - 한 요청의 최대 크기 입니다.
    - 여러 파일 및 전송값 등을 합한 최대 크기 입니다.
    - 기본값은 -1L이므로 제한이 없습니다.

```java
protected void doPost(
    HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        TripFileUtils uploadUtil = TripFileUtils.create(request.getServletContext());
        // 부분 생략...
        Collection<Part> parts = request.getParts();
        
        Iterator<Part> i = parts.iterator();
        
        while(i.hasNext()) {
            Part p = i.next();
            String formTypeName = p.getName();

            switch (formTypeName) {
            case "memberId":
                memberId = Integer.parseInt(request.getParameter("memberId"));
                break;
            case "name":
                name = request.getParameter(formTypeName);
                break;
            case "uploadFile":
                if(!p.getSubmittedFileName().equals("")) {
                    String subFolder = uploadUtil.createFilePath();
                    changeFileName = TripFileUtils.changeFileName(p);
                    uploadUtil.saveFile(p, subFolder, changeFileName);

                    changeFileName = "/assets/resources/upload/" + subFolder + "/" + changeFileName;
                    originFileName = p.getSubmittedFileName();
                } else {
                    String sampleImgPath = ProductPath.sampleImg();
                    originFileName = sampleImgPath.substring(sampleImgPath.lastIndexOf("/") + 1);
                    changeFileName = sampleImgPath;
                }
                break;
            case "description":
                description = request.getParameter(formTypeName);
                break;
            case "price":
                price = Integer.parseInt(request.getParameter(formTypeName));
                break;
            case "stock":
                stock = Integer.parseInt(request.getParameter(formTypeName));
                break;
            case "countryId":
                countryId = Integer.parseInt(request.getParameter("countryId"));
                break;
            }
        }
        
        Product product = new Product(name, price, stock, description, originFileName, changeFileName, memberId, countryId);
        
        int result = new ProductServiceImpl().insertProduct(product);
        
        // 부분 생략...
}
```
- 파일 데이터는 HttpServletRequest 객체의 getParameter() 메서드로 추출할 수 없고 Part 객체를 활용하여 단일 업로드 : getPart() 혹은 다중 업로드 : getParts() 메서드를 사용해야합니다.

- iterator를 활용하여 넘겨 받은 데이터인 name 속성 값을 하나 씩 추출하여 해당 값들을 HttpServletRequest 객체를 사용하여 파라미터 값을 저장합니다.

- 파일 같은 경우에는 위에서 설명한대로 원본 파일명과 파일이 저장된 물리적 경로명으로 저장합니다.

#### ProductPath.java
> URL에서 상품아이디 추출 메서드
```java
public static int getProductId(HttpServletRequest request, String pathInfo) {
    String path = "";
    
    if(pathInfo == null || pathInfo.equals("/")) {
        String uri = request.getRequestURI();
        path = uri.substring(uri.lastIndexOf("/") + 1);
    } else {
        path = pathInfo.substring(1);
    }
    
    int productId = 0;
    
    if(path.matches("\\d+")) {
        productId = Integer.parseInt(path);
    }
    
    return productId;
}
```
- 상품 아이디를 추출할 경우가 많아서 해당 부분의 코드를 따로 메서드로 만들었습니다.

- `HttpServletRequest`와 `URL 경로 정보`를 매개변수로 받아서 상품의 아이디를 추출하는 메서드 입니다.

- 상품 아이디는 정수형 데이터 타입이므로 `matches 메서드를 사용하여 정규표현식으로 상품 아이디를 정수형으로 변환 후 반환`합니다.
    - `\d`는 `숫자 한 글자만` 찾습니다.
    - `+`는 *'하나 혹은 그 이상 연결된'* 이란 뜻 입니다.
        - 즉 `\d+`는 `하나 혹은 그 이상 연결된 숫자` 입니다.

> 상품 대체 이미지 랜덤 반환 메서드
```java
public static String sampleImg() {
    int sampleNum = (int)(Math.random() * 4) + 1;
    String sampleImgPath = "assets/images/product/sample/product-sample-" + sampleNum + ".png";
    return sampleImgPath;
}
```
- 위의 메서드는 **상품을 등록할 때 첨부한 이미지가 없을 경우 대체 이미지 4개 중 랜덤으로 하나 정해서 해당 이미지 경로를 반환** 합니다.

#### TripFileUtils.java
```java
private String uploadPath;
private ServletContext app;

public static TripFileUtils create(ServletContext app) {
    TripFileUtils tripFileUtils = new TripFileUtils();
    tripFileUtils.setApp(app);
    tripFileUtils.setUploadPath(app.getRealPath("/assets/resources/upload/"));
    
    return tripFileUtils;
}
private void setApp(ServletContext app) {
    this.app = app;
}

private void setUploadPath(String realPath) {
    this.uploadPath = realPath;
}
// 부분 생략...
```
- 컨텍스트 정보를 담고 있는 데이터를 `app`변수로 받아서 getRealPath() 메서드로 상품 이미지를 저장할 실제 파일 시스템 경로를 얻습니다.

- 업로드한 파일을 저장할 서버의 실제 경로를 설정합니다.

> 파일 저장 메서드
```java
public void saveFile(Part part, String subFolder, String fileName) {
    String realPath = this.uploadPath + subFolder + "/" + fileName;
    
    try (
            InputStream fis = part.getInputStream();
            OutputStream fos = new FileOutputStream(realPath);
    ) {
        byte[] buffer = new byte[1024];
        int len = 0;
        
        while((len = fis.read(buffer, 0, 1024)) != -1) fos.write(buffer, 0, len);
    } catch(IOException e) {
        e.printStackTrace();
    }
}
```
- Part 객체와 subFolder 경로, fileName을 매개변수로 받아서 실제 파일이 저장되는 경로를 생성하여 해당 경로에 파일을 저장합니다.

##### 추가 수정 사항
```
/로 할 경우 운영체제마다 경로 구분자가 달라 문제가 발생할 위험이 있으므로 Paths 클래스의 get() 메서드 사용하기!!!
```

> /resources/upload/ 하위 폴더 생성 메서드
```java
public String createFilePath() {
    LocalDateTime date = LocalDateTime.now();
    
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    String[] paths = formatter.format(date).split("-");
    
    String result = paths[0] + "/" + paths[1] + "/" + paths[2];
    
    createFolders(result);
    
    return result;
}
```
- 업로드한 파일을 저장할 때 upload 하위에 모든 파일을 저장하는 것보다 날짜 별로 폴더를 구분하여 파일을 저장하는 것이 관리하기 효율적일 것이라고 판단하여 현재 날짜를 구해서 해당 날짜로 하위 폴더를 만드는 메서드입니다. **/resources/upload/yyyy/MM/dd**

##### 추가 수정 사항
```
/로 할 경우 운영체제마다 경로 구분자가 달라 문제가 발생할 위험이 있으므로 Paths 클래스의 get() 메서드 사용하기!!!
```

> 폴더 생성 메서드
```java
private void createFolders(String paths) {
    File folders = new File(uploadPath, paths);
    
    if(!folders.exists()) folders.mkdirs();
}
```
- 폴더를 생성하는 메서드로 존재하지 않을 경우만 생성합니다.

> 파일 명 변경 메서드
```java
public static String changeFileName(Part p) {
    String originFileName = p.getSubmittedFileName();
    String ext = originFileName.substring(originFileName.lastIndexOf("."));
    
    String currentDate = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
    
    int randomValue = (int)(Math.random() * 99999999) + 1;
    
    String changeFileName = "trip-log_" + currentDate + "_" + randomValue + ext;
    
    return changeFileName;
}
```
- 저장할 상품 이미지 파일 명을 우리 프로젝트에 맞게 파일명을 변환하는 메서드입니다.

- `프로젝트명_현재날짜_랜덤숫자값.확장자`로 변경합니다.

### 상품 검색, 상품 정렬 기능 및 페이징 처리
- 상품 검색과 정렬 조건을 추가하여 기본적인 데이터 조회에서 확장하여 구현하였습니다.

- 페이징 처리를 통해 많은 데이터를 전부 조회하여 출력하는 비효율적인 방법이 아니라 특정 갯수만 출력하여 사용자 측면에서도 페이지 길이가 길어져 스크롤을 계속 할 필요가 없어지고 속도도 빨라지고 부하가 적은 이점이 생깁니다.

> ProductSearchDTO.java
```java
@Data
@AllArgsConstructor
public class ProductSearchDTO {
	private String keyword;
	private String sort;
}
```

> ProductListDTO.java
```java
@Data
@AllArgsConstructor
public class ProductListDTO {
	private int productId;
	private String name;
	private int price;
	private String changeFileName;
	private Date createdAt;
	private String countryName;
	private double score;
}
```

- **`기본생성자 생성 어노테이션을 사용하지 않을 시 DTO의 필드 변수 순서는 SELECT 절의 컬럼 나열 순서와 동일해야 합니다.`**

#### ProductListPageController.java
> 검색 & 정렬 조건 파라미터 값 처리
```java
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword") : "";
		String sort = request.getParameter("sort") != null ? request.getParameter("sort") : "";

		ProductSearchDTO productSearchDTO = new ProductSearchDTO(keyword, sort);

		// 페이징 처리 부분 코드 생략 ...

        // request 영역에 저장 및 포워딩 처리 부분 코드 생략 ...
	}
```

- 파라미터 키값으로 넘어온 keyword와 sort는 값이 없을 경우 null로 처리되어서 **삼항 연산자를 통해서 null일 경우 빈 문자열로 초기화** 하였습니다. `이렇게 한 이유는 null일 경우 ProductSearchDTO의 인스턴스를 생성할 때 NullPointerException이 발생하기 때문`입니다.

> 페이징 처리
```java
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // 검색 관련 코드 생략 ...
    int listCount = new ProductServiceImpl().selectByProductNameCount(productSearchDTO);
            
    int itemLimit = 12;
    int pageLimit = 10;

    int currentPageNo = request.getParameter("cpage") != null ? Integer.parseInt(request.getParameter("cpage")) : 1;

    PageInfo pageInfo = new PageInfo(listCount, currentPageNo, pageLimit, itemLimit);

    // 보여줄 상품 목록 조회 후 저장하는 코드 생략 ...
    // request 영역에 저장 및 포워딩 처리 부분 코드 생략 ...
}
```

> 페이징 처리 관련 DAO 코드
```java
// 페이지 정보로 상품 데이터 조회
public List<ProductListDTO> findByProductNameLike(SqlSession sqlSession, ProductSearchDTO productSearchDTO, PageInfo pageInfo) {
    int offset = (pageInfo.getCurrentPageNo() - 1) * pageInfo.getItemLimit();
    RowBounds rowBounds = new RowBounds(offset, pageInfo.getItemLimit());
    
    return sqlSession.selectList("productMapper.findByProductNameLike", productSearchDTO, rowBounds);
}
```

##### 추가 수정 사항
```
cpage가 아닌 명확하게 전달하기 위해 currentPage로 변경하기!!
```

> 페이징 처리를 위한 데이터 수 조회
```xml
<!-- 상품의 전체 갯수 조회 -->
<select id="selectByProductNameCount" resultType="_int">
    SELECT COUNT(*) FROM TB_PRODUCT
    WHERE 1=1
    <if test="sort == 'recentValue' or sort == 'reviewValue' or sort == 'priceValue'">
        AND NAME LIKE '%${keyword}%'
    </if>
</select>
```
- 페이징 처리 코드로 검색 조건이 없을 경우에는 전체 데이터 수를 조회하고 있을 경우에는 조건에 맞는 데이터 수를 조회하여 `int`형으로 반환합니다.

- resultType으로 `_int`를 사용한 이유는 그냥 int로 작성하면 Integer타입으로 반환되기 때문입니다.

- 동적 sql을 사용하여 정렬 조건을 작성했습니다. [참고자료](https://mybatis.org/mybatis-3/ko/dynamic-sql.html)

> 페이징 처리와 검색과 정렬 조건을 포함한 전체 상품 목록 조회
```java
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // 검색 및 페이징 처리 코드 생략 ...
    List<ProductListDTO> pList = new ProductServiceImpl().selectByProductName(productSearchDTO, pageInfo);
    // request 영역에 저장 및 포워딩 처리 부분 코드 생략 ...
}
```
```xml
<!-- 상품의 전체 데이터 조회(키워드가 있을 검색 포함) -->
<resultMap type="kr.co.khedu.product.model.dto.ProductListDTO" id="productListKeywordResultMap">
    <result column="PRODUCT_ID" property="productId" />
    <result column="NAME" property="name" />
    <result column="PRICE" property="price" />
    <result column="CHANGE_FILE_NAME" property="changeFileName" />
    <result column="CREATED_AT" property="createdAt" />
    <result column="COUNTRY_NAME" property="countryName" />
    <result column="SCORE" property="score" />
</resultMap>
```
- resultMap을 사용하여 DTO 클래스의 필드변수명이 카멜표기법으로 되어 있어서 `필드 변수와 DB 테이블의 컬럼과 매칭` 시킵니다.

```xml
<select id="findByProductNameLike" resultMap="productListKeywordResultMap">
    SELECT 
        TP.PRODUCT_ID,
        TP.NAME,
        TP.PRICE,
        TP.CHANGE_FILE_NAME,
        TP.CREATED_AT,
        TRC.NAME AS COUNTRY_NAME,
        ROUND(NVL(AVG(TPR.SCORE), 0), 1) AS SCORE
    FROM TB_PRODUCT TP
        LEFT JOIN TB_PRODUCT_REVIEW TPR ON TP.PRODUCT_ID = TPR.PRODUCT_ID
        LEFT JOIN TR_COUNTRY TRC ON TP.COUNTRY_ID = TRC.COUNTRY_ID 
    WHERE 1 = 1 AND TP.NAME LIKE '%${keyword}%'
    GROUP BY TP.PRODUCT_ID, TP.NAME, TP.PRICE, TP.CHANGE_FILE_NAME, TRC.NAME, TP.CREATED_AT
    <choose>
        <when test="sort == 'reviewValue'">
            ORDER BY SCORE DESC, TP.CREATED_AT DESC
        </when>
        <when test="sort == 'priceValue'">
            ORDER BY TP.PRICE DESC, TP.CREATED_AT DESC
        </when>
        <otherwise>
            ORDER BY TP.CREATED_AT DESC
        </otherwise>
    </choose>
</select>
```
- 정렬은 최신순, 평점순, 가격순으로 총 3가지이고 최신순이 기본 정렬입니다.

- **상품 목록에선 기본 상품 정보에 더해 해당 상품의 리뷰(평점 정보), 국가 정보를 출력**해야 하고 상품 테이블이 기준이 되므로 `LEFT JOIN을 사용`하여 JOIN을 하였습니다. (상품 찜 정보도 출력하지만 이건 [상품 찜 기능에서 설명](#상품-찜-기능))

- 마찬가지로 `동적 sql choose-when-otherwise을 사용`하여 정렬 조건에 따라 데이터를 조회되도록 작성하였습니다.

### 상품 찜 기능
- 사용자가 특정 상품을 저장하는 기능으로 마이 페이지에서 내 찜 목록 조회를 통해 저장한 상품을 볼 수 있습니다.

```xml
<!-- 회원 아이디로 해당 회원의 상품 찜 목록 수 조회 -->
<select id="selectMyProductFavoriteCount" resultType="_int">
    SELECT COUNT(*)
    FROM TB_PRODUCT_FAVORITES
    WHERE MEMBER_ID = #{memberId}
</select>

<!-- 회원 아이디로 해당 회원의 상품 찜 목록 조회 -->
<resultMap type="kr.co.khedu.member.model.dto.MemberFavoriteProductDTO" id="myProductFavoriteResultMap">
    <result column="PRODUCT_ID" property="productId" />
    <result column="NAME" property="productName" />
    <result column="PRICE" property="price" />
    <result column="STOCK" property="stock" />
</resultMap>
<select id="selectMyProductFavorite" resultMap="myProductFavoriteResultMap">
    SELECT TPF.PRODUCT_ID, TP.NAME, TP.PRICE, TP.STOCK
    FROM TB_PRODUCT_FAVORITES TPF
        LEFT JOIN TB_PRODUCT TP ON TPF.PRODUCT_ID = TP.PRODUCT_ID
    WHERE TPF.MEMBER_ID = #{memberId}
</select>
```
- 상품 테이블이 아닌 상품 찜 테이블을 기준으로 LEFT JOIN을 해서 데이터를 조회합니다.

#### ProductFavoriteRegisterController.java
```java
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    request.setCharacterEncoding("UTF-8");
    int productId = Integer.parseInt(request.getParameter("productId"));
    int memberId = Integer.parseInt(request.getParameter("memberId"));
    
    int result = new ProductServiceImpl().insertProductFavoirte(new ProductFavoriteDTO(productId, memberId));
    
    if(result > 0) {
        JSONObject jsonObj = new JSONObject();
        jsonObj.put("title", "상품 찜");
        jsonObj.put("icon", "success");
        jsonObj.put("text", "상품 찜 등록 성공");
        
        response.setContentType("application/json; charset=utf-8");
        response.getWriter().print(jsonObj);
    }
}
```
- 파라미터 값을 추출하여 찜 데이터로 등록하고 비동기 처리를 해주고 있기 때문에 JSON 형태로 값을 반환해야해서 JSONObject 객체로 인스턴스를 생성합니다.

- 생성된 인스턴스를 활용하여 key-value 형태로 저장되므로 Map 형식이라 put 메서드로 데이터를 저장합니다.

##### 추가 수정 사항
```
new ProductServiceImpl().insertProductFavoirte(...);
=> 오타 수정하기
```

> 상품 찜 자바스크립트 메서드
```js
const heartBtn = () => {
    $("#heartBtn").click((e) => {
        const $icon = $(e.currentTarget).find("i"); // i 태그 선택

        if (!$icon.hasClass("heart-active")) {
            Swal.fire({
                title: "찜 하기",
                icon: "question",
                text: "상품을 찜 하시겠습니까?",
                confirmButtonColor: "#118C8C",
                confirmButtonText: "찜",
                showCancelButton: true,
                cancelButtonText: "취소"
            }).then((result) => {
                if(result.isConfirmed) {
                    $.ajax({
                        url: "/trip-log/products/auth/favorite",
                        method: "post",
                        data: {
                            productId: productInfo.productId,
                            memberId: productInfo.memberId
                        },
                        success: (data) => {
                            Swal.fire({
                                title: data.title,
                                icon: data.icon,
                                text: data.text
                            }).then((result) => {
                                if(result.isConfirmed) {
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
                                confirmButtonText: "확인"
                            }).then((result) => {
                                if(result.isConfirmed) {
                                    console.log("error : " + error);
                                    location.href = "/trip-log/products/detail/" + productInfo.productId;
                                }
                            });
                        }
                    });
                }
            });
        } else {
            Swal.fire({
                title: "찜 취소",
                icon: "question",
                text: "상품 찜을 취소하시겠습니까?",
                confirmButtonColor: "$colorValue",
                confirmButtonText: "찜 취소",
                showCancelButton: true,
                cancelButtonText: "취소"
            }).then((result) => {
                if(result.isConfirmed) {
                    $.ajax({
                        url: "/trip-log/products/auth/delete/favorite",
                        method: "post",
                        data: {
                            productId: productInfo.productId,
                            memberId: productInfo.memberId
                        },
                        success: (data) => {
                            Swal.fire({
                                title: data.title,
                                icon: data.icon,
                                text: data.text
                            }).then((result) => {
                                if(result.isConfirmed) {
                                    location.reload(true);
                                } 
                            });
                            $icon.removeClass("heart-active");
                        },
                        error: (error) => {
                            Swal.fire({
                                title: "찜 취소소",
                                icon: "error",
                                text: "찜 취소소 오류",
                                confirmButtonText: "확인"
                            }).then((result) => {
                                if(result.isConfirmed) {
                                    console.log("error : " + error);
                                    location.href = "/trip-log/products/detail/" + productInfo.productId;
                                }
                            });
                        }
                    });
                }
            });
        }
    });
}
```
- 상품 찜 기능은 찜 아이콘 요소를 선택해서 해당 상품을 찜할 경우 `heart-active` 클래스를 추가하고 아닌 상태는 해당 클래스를 제거하여 `heart-active 클래스`로 현재 상품이 찜 된 상품인지 아닌지를 구분하도록 하였습니다.

- 비동기처리가 성공적으로 처리된 후에는 결과가 화면에 바로 반영되지 않으므로 `location의 reload() 메서드`를 사용하여 찜 기능의 결과가 바로 화면에서 업데이트되도록 했습니다.

##### 추가 수정 사항
```
'찜 취소소' 오타 수정하기!!
```

### 상품 리뷰 기능
- 상품의 별점 기능으로 별점을 통해 평점을 구하는 것이 목표인 기능입니다.

#### ProductReviewController.java
```java
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String pathInfo = request.getPathInfo();
    int productId = ProductPath.getProductId(request, pathInfo);
    double score = Double.parseDouble(request.getParameter("score"));
    int memberId = Integer.parseInt(request.getParameter("memberId"));
    
    int result = new ProductServiceImpl().insertProductReview(new Review(score, memberId, productId));
    
    if(result > 0) {
        // JSON 객체로 만들어서 응답
        JSONObject jsonObj = new JSONObject(); // {}
        jsonObj.put("title", "리뷰 등록");
        jsonObj.put("icon", "success");
        jsonObj.put("text", "리뷰 등록 성공");
        
        response.setContentType("application/json; charset=utf-8");
        response.getWriter().print(jsonObj);
    }
}
```

> productDetail.js의 리뷰 등록 메서드의 등록 버튼 부분
```js
const $reviewRegisterBtn = $("#reviewRegisterBtn");
    $reviewRegisterBtn.on("click", function () {
        const $starInputArr = $(".star-icon.filled");
        const score = $starInputArr.length / 2;
        $.ajax({
            url: "/trip-log/products/review/" + productInfo.productId,
            method: "post",
            data: {
                memberId: productInfo.memberId,
                score: score
            },
            success: (data) => {
                Swal.fire({
                    title: data.title,
                    icon: data.icon,
                    text: data.text
                }).then((result) => {
                    if(result.isConfirmed) {
                        location.reload(true);
                    } 
                });
            },
            error: () => {
                Swal.fire({
                    title: "리뷰 등록",
                    icon: "error",
                    text: "리뷰 등록 오류",
                    confirmButtonText: "확인"
                }).then((result) => {
                    if(result.isConfirmed) {
                        location.href = "/trip-log/products/detail/" + productInfo.productId;
                    }
                });
            }
        });
```

- 성공적으로 처리가 되었을 경우 해당 페이지가 다시 로드되지 않으므로 `location의 reload() 메서드를 사용하여 상품 상세 페이지를 리로드` 시켜 등록된 별점에 의해 평점 값이 업데이트 되도록 구현하였습니다.