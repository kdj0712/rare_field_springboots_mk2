document.addEventListener("DOMContentLoaded", function () {
    // URL에서 쿼리 파라미터 가져오기
    const urlParams = new URLSearchParams(window.location.search);
    const keyName = urlParams.get('key_name');
    const searchWord = urlParams.get('search_word');

    // 폼 입력 필드에 값 설정하기
    if (keyName !== null) {
        document.getElementById('keyNameSelect').value = keyName;
    }
    if (searchWord !== null) {
        document.getElementById('searchWordInput').value = searchWord;
    }
    if (keyName && keyName !== 'dise_KCD_code_range') {
        document.getElementById('keyNameSelect').value = keyName;
        document.getElementById('searchWordInput').value = searchWord;
    }
});

function fetchDataByRange(range) {
    var rangeValue = range || '';

    document.getElementById("hiddenKeyName").value = 'dise_KCD_code_range';
    document.getElementById("hiddenSearchWord").value = rangeValue; // 범위 값 설정
    goToPage(1); 
}

function goToPage(pageNumber) {
    var form = document.getElementById('searchForm');
    if (form) {
        var keyName = form.querySelector('select[name="key_name"]').value;
        var searchWord = form.querySelector('input[name="search_word"]').value;

        // hidden field 값을 사용해서 URL을 구성
        var hiddenKeyName = document.getElementById('hiddenKeyName').value;
        var hiddenSearchWord = document.getElementById('hiddenSearchWord').value;

        if (hiddenKeyName === 'dise_KCD_code_range') {
            keyName = hiddenKeyName;
            searchWord = hiddenSearchWord;
        }

        var baseUrl = form.action.split('?')[0];
        var queryString = `?currentPage=${pageNumber}`;

        if (searchWord) {
            queryString += `&key_name=${encodeURIComponent(keyName)}`;
            queryString += `&search_word=${encodeURIComponent(searchWord)}`;
        }

        window.location.href = baseUrl + queryString;
    } else {
        console.error("Form not found");
    }
}

// 페이지 로드 시 기존 값 설정
window.onload = function () {
    const urlParams = new URLSearchParams(window.location.search);

    if (urlParams.has('key_name')) {
        document.getElementById('hiddenKeyName').value = urlParams.get('key_name');
    }

    if (urlParams.has('search_word')) {
        document.getElementById('hiddenSearchWord').value = urlParams.get('search_word');
    }
};

function fetchAllDiseases() {
    var baseUrl = window.location.origin + window.location.pathname;
    window.location.href = baseUrl;
}

document.addEventListener('DOMContentLoaded', function() {
    const searchButton = document.getElementById('searchButton');
    const searchInput = document.getElementById('searchWordInput');

    searchButton.addEventListener('click', function(event) {
      if (searchInput.value.trim() === '') {
        event.preventDefault();
        alert('검색할 내용을 입력해 주세요');
      }
    });
  });