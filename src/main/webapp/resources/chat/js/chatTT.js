(function() {
    $.fn.menuBar = function() {
        this.each(function(index) {
            var $menuBar = null,
                $menuList = null,
                $menuSelect = null;

            function init(el) {
                $menuBar = $(el);
                $menuList = $menuBar.find('li');
            }

            function event() {
                $menuList.on('click', function() {
                    if ($menuSelect)
                        $menuSelect.removeClass('active');

                    $menuSelect = $(this);
                    $menuSelect.addClass('active');

                    // 메뉴에 대한 내용 표시
                    var $content = $menuSelect.parent('ul').next().children().eq($(this).index());
                    $content.show().siblings().hide();
                });
            }
            init(this);
            event();
        });
        return this;
    }
})(jQuery);
