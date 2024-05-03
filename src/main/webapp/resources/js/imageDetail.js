$(function(){
	// 모달 내 버튼 클릭 시 슬라이드 변경
    $(document).on("click",".modalPicBody button",function() {
        let slideDirection = $(this).attr("aria-label");
        if (slideDirection === "Previous slide") {
            plusSlides(-1); // 이전 슬라이드로 이동
        } else if (slideDirection === "Next slide") {
            plusSlides(1); // 다음 슬라이드로 이동
        }
    });
	
    $(document).on("click", ".prServiceThumb", function(){
        let sprviseAtchmnflNo = $(this).data("sprviseAtchmnflNo");
        $(".btn.btn-success").data("sprviseAtchmnflNo", sprviseAtchmnflNo);

        // 클릭된 이미지가 몇 번째 슬라이드인지 찾아서 슬라이드 인덱스 설정
        clickedIndex = $(this).closest("li").index();

        // 클릭한 이미지의 URL을 가져와서 data-picture-url 속성에 설정
        let imageUrl = $(this).attr("src");
        $("#modalPicture").attr("data-picture-url", imageUrl);

        // 클릭한 이미지의 URL을 포함한 이미지 목록을 가져옴
        let images = document.querySelectorAll(".prServiceThumb");
        let imageUrls = [];
        images.forEach(function(image) {
            imageUrls.push(image.getAttribute("src"));
        });
        console.log("가져온 이미지 url 배열",imageUrls);
        
        totalIdx = imageUrls.length;
        console.log("슬라이드 토탈 인덱스", totalIdx);
        
        // 이미지 데이터를 받아와서 동적으로 이미지 요소를 생성
        let str = "";
        str += "<li style='list-style-type: none; display: inline-block;'>";
		str += "<button type='button' aria-label='Previous slide' style='background: none; margin-left:-15px; border: none; position: absolute; top: 42%;'>";
		str += "<i class='mdi mdi-arrow-left-drop-circle-outline' style='font-size: 40px;'></i></button></li>";
        imageUrls.forEach(function(url) {
            str += "<li style='list-style-type: none; display: inline-block;'>";
            str += "<img src='" + url + "' style='width:390px; height:390px; margin-left:35px;'>";
            str += "</li>";
        });
        str += "<li style='list-style-type: none; display: inline-block;'>";
			str += "<button type='button' aria-label='Next slide' style='background: none; margin-left:-2px; border: none; position: absolute; top: 42%;' >";
			str += "<i class='mdi mdi-arrow-right-drop-circle-outline' style='font-size: 40px;'></i></button></li>";

        // 모달 바디에 동적으로 추가된 이미지를 삽입
        $("#ulPrt").html(str);

        // 클릭한 이미지의 인덱스를 가져와서 showSlides 함수에 전달
        showSlides();
    });
    
    // 슬라이드 쇼 함수
    let slideIndex = 0;
    showSlides();

    function plusSlides(n) {
        slideIndex += n;
        showSlides();
    }

    function showSlides() {
    	console.log("왔다2");
        let slides = document.querySelectorAll(".modalPicBody img");
        console.log("slides.length : " + slides.length);
        
        if (slideIndex >= slides.length) {
        	slideIndex = 0 
        }
        if (slideIndex < 0) {
        	slideIndex = slides.length - 1 
        	}
        for (let i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        if (slides[slideIndex]) {
            slides[slideIndex].style.display = "block";
        } else {
        }
    }	
});