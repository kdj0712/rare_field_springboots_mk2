document.addEventListener("DOMContentLoaded", function () {
    // URL에서 쿼리 파라미터 가져오기
    var urlParams = new URLSearchParams(window.location.search);
    setFormValuesFromUrl(urlParams);

    // 검색 버튼 클릭 이벤트
    var searchButton = document.getElementById('searchButton');
    searchButton.addEventListener('click', function (event) {
        var searchInput = document.getElementById('searchWordInput');
        var keyNameSelect = document.getElementById('keyNameSelect');

        if (searchInput.value.trim() === '') {
            event.preventDefault();
            alert('검색할 내용을 입력해 주세요');
            return;
        }

        // 새로운 URL 파라미터 설정
        urlParams.set('key_name', keyNameSelect.value);
        urlParams.set('search_word', searchInput.value);

        var currentPageInput = document.getElementById('currentPage');
        currentPageInput.value = 1;
        urlParams.set('currentPage', 1);

        // 새로운 URL로 리디렉션
        var newUrl = `${window.location.pathname}?${urlParams.toString()}`;
        window.location.href = newUrl;
    });

    // 카테고리 클릭 이벤트
    var categoryLinks = document.querySelectorAll('.nav-link[data-category]');
    categoryLinks.forEach(function(link) {
        link.addEventListener('click', function(event) {
            event.preventDefault(); // 기본 동작 막기
            
            var selectedCategory = this.getAttribute('data-category');
            
            // URL 파라미터 업데이트
            if (selectedCategory === '전체') {
                urlParams.delete('category');
            } else {
                urlParams.set('category', selectedCategory);
            }

            // 페이지 번호를 1로 설정
            urlParams.set('currentPage', 1);
            
            // 새로운 URL로 리디렉션
            var newUrl = `${window.location.pathname}?${urlParams.toString()}`;
            window.location.href = newUrl;
        });
    });
});

function setFormValuesFromUrl(urlParams) {
    var keyNameSelect = document.getElementById('keyNameSelect');
    var searchInput = document.getElementById('searchWordInput');
    var categoryInput = document.getElementById('category');

    if (urlParams.has('key_name')) {
        keyNameSelect.value = urlParams.get('key_name');
    }
    if (urlParams.has('search_word')) {
        searchInput.value = urlParams.get('search_word');
    }

    if (urlParams.has('category') && urlParams.get('category') !== '') {
        categoryInput.value = urlParams.get('category');
    }
    if (urlParams.has('currentPage')) {
        var currentPageInput = document.getElementById('currentPage');
        if (currentPageInput) {
            currentPageInput.value = urlParams.get('currentPage');
        }
    }
}


function setCurrentPageAndNavigate(recordId, currentPage, keyName, searchWord, category) {
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "/trend/saveSessionData", true);
    xhr.setRequestHeader("Content-Type", "application/json");

    var params = {
        currentPage: currentPage
    };

    // 값이 존재하는 경우에만 params에 추가
    if (keyName !== undefined && keyName !== null && keyName !== '') {
        params.keyName = keyName;
    }
    if (searchWord !== undefined && searchWord !== null && searchWord !== '') {
        params.searchWord = searchWord;
    }
    if (category !== undefined && category !== null && category !== '') {
        params.category = category;
    }

    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var url = "/trend/read/" + recordId;
            window.location.href = url;
        }
    };

    xhr.send(JSON.stringify(params));
}

function goToPage(pageNumber) {
    var form = document.getElementById('newsForm');
    
    if (!form) {
        console.error("Form with ID 'newsForm' not found");
        return;
    }

    var keyNameElement = form.querySelector('select[name="key_name"]');
    var searchWordElement = form.querySelector('input[name="search_word"]');
    var categoryElement = document.getElementById('category'); // 카테고리 입력 필드

    if (!keyNameElement || !searchWordElement) {
        console.error("Key name select or search word input not found");
        return;
    }

    var keyName = keyNameElement.value;
    var searchWord = searchWordElement.value;
    var category = categoryElement ? categoryElement.value : ''; // 카테고리 값

    var baseUrl = form.action ? form.action.split('?')[0] : '';
    if (!baseUrl) {
        console.error("Form action is not properly set");
        return;
    }

    var queryString = '';

    if (searchWord) {
        queryString += `?key_name=${encodeURIComponent(keyName)}`;
        queryString += `&search_word=${encodeURIComponent(searchWord)}`;
    }

    if (category) {
        queryString += (queryString ? '&' : '?') + `category=${encodeURIComponent(category)}`;
    }

    if (queryString) {
        queryString += `&currentPage=${pageNumber}`;
    } else {
        queryString += `?currentPage=${pageNumber}`;
    }

    console.log("Navigating to:", baseUrl + queryString);
    window.location.href = baseUrl + queryString;
}
