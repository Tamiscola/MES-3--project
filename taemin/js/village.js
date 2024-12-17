<script>
    let popup;

    $(document).ready(function () {
        $(document).on("click", "#modelLoginOk", function (e) {
            location.href = "/login";
        });
    });

    $(".joinGo").on('click', function (e) {
        const domain = window.location.protocol + "//" + window.location.host;
        const errDomain = domain + '/error';
        const resultAuthDomain = domain + '/member/inicis/return';

        $('#successUrl').val(resultAuthDomain);
        $('#failUrl').val(errDomain);
        $('#tr_url').val(resultAuthDomain);

        $('#certifyModal').modal({
            showClose: false,
            clickClose: false
        });

        return false;
    });

    // sns 회원 가입
    function goOauth(type) {
        const ajaxUrl = "/sns/login";
        let apiData = {};
        apiData.type = type;
        apiData.mode = 'signup';
        apiData = JSON.stringify(apiData);

        keymall.api({
            'url': ajaxUrl,
            'type': 'POST',
            'data': apiData,
            'dataType': 'text',
            'contentType': 'application/json; charset=utf-8',
            'option': {loading: true},
            'callback': function (type, result) {
                if (type === 'success') {
                    let obj = JSON.parse(result);
                    if (obj.response) {
                        location.href = obj.response;
                    }
                } else {
                    console.error("requestSignInMember exception");
                }
            }
        });
    }

    function chkAuth(li) {
        if (li === 'liInicisAuth') {
            $('#liKmcisAuth').removeClass('on');
            $('#liInicisAuth').addClass('on');
        } else {
            $('#liKmcisAuth').addClass('on');
            $('#liInicisAuth').removeClass('on');
        }
    }

    function openAuthPop() {
        if ($('#liInicisAuth').hasClass('on')) {
            openInicisForm();
        } else if ($('#liKmcisAuth').hasClass('on')) {
            openKMCForm();
        }
    }

    function openInicisForm() {
        let window = popupCenter();
        if (window !== undefined && window !== null) {
            document.inicisForm.setAttribute("target", "sa_popup");
            document.inicisForm.setAttribute("post", "post");
            document.inicisForm.setAttribute("action", "https://sa.inicis.com/auth");
            document.inicisForm.submit();
        }
    }

    function popupCenter() {
        let _width = 400;
        let _height = 620;
        let xPos = (document.body.offsetWidth / 2) - (_width / 2); // 가운데 정렬
        xPos += window.screenLeft; // 듀얼 모니터일 때

        popup = window.open("", "sa_popup", "width=" + _width + ", height=" + _height + ", left=" + xPos + ", menubar=yes, status=yes, titlebar=yes, resizable=yes");
        chkPopup();
        return popup;
    }

    window.name = "한국모바일 본인인증";

    function openKMCForm() {
        let userAgent = navigator.userAgent;
        // 모바일인 경우 (변동사항 있을경우 추가 필요)
        if (userAgent.match(/iPhone|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null || userAgent.match(/LG|SAMSUNG|Samsung/) != null) {
            popup = window.open('', 'KMCISWindow');
            chkPopup();
        }
        // 모바일이 아닌 경우
        else {
            // 기본 팝업 size
            let jWidth = "425";
            let jHeight = "600";

            userAgent = navigator.userAgent.toLowerCase();

            if (userAgent.indexOf("chrome") !== -1) {
                jWidth = "560";
                jHeight = "770";
            } else if (userAgent.indexOf("safari") !== -1) {
                jWidth = "441";
                jHeight = "588";
            }

            popup = window.open('', 'KMCISWindow', 'width=' + jWidth + ', height=' + jHeight + ', resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=435, top=250');
            chkPopup();
        }

        if (popup == null) {
            alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n    화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
        }

        document.reqKMCISForm.action = 'https://www.kmcert.com/kmcis/web/kmcisReq.jsp';
        document.reqKMCISForm.target = 'KMCISWindow';
        document.reqKMCISForm.submit();
    }

    function chkPopup() {
        if (typeof (popup) == 'undefined' || popup.closed) {
            const ajaxUrl = "/member/chkSelfAuth";

            let ajaxData = {};
            ajaxData = JSON.stringify(ajaxData);

            keymall.api({
                'url': ajaxUrl,
                'type': 'POST',
                'data': ajaxData,
                'dataType': 'json',
                'contentType': 'application/json; charset=utf-8',
                'option': {loading: false},
                'async': false,
                'callback': function (type, result) {
                    if (result.message === 'OK') {
                        location.href = "/authJoin";
                        return false;
                    }
                    if (result.message === "DUP") {
                        modelOpen("commonModel", "이미 K.VILLAGE에 가입하신 회원입니다.<br>아이디 찾기를 통해 가입하신 아이디를 확인해주세요.", false);
                    }
                }
            });
        } else {
            setTimeout("chkPopup();", 1000);
        }
    }

    function closePopupOpen() {
        $('#alertModal').modal({
            showClose: false,
            closeExisting: false,
            clickClose: false
        });
    }

    function popupClose() {
        $.modal.close();
    }
</script>

<script>
    let latelyPageData = {
        height: 0,
        page: 2,
        call: true
    }
    $(document).ready(function() {
        $(document).on("scroll", "#latelyList", function() {
            const obj = $(this);
            let height = obj[0].scrollHeight - obj.height();
            if(Math.round(height) == Math.round(obj.scrollTop()) && height > latelyPageData.height && latelyPageData.call) {
                let goodsList = async () => {
                    latelyPageData.height = height;
                    latelyPageData.call = false;
                    keymall.listLatelyGoods('pc', latelyPageData.page);
                };
                goodsList().then(() => {
                    latelyPageData.page++;
                    latelyPageData.call = true;
                });
            }
        });
    });
</script>