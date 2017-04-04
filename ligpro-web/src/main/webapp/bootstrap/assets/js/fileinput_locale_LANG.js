/*!
 * FileInput <language> Translations - Template file for copying and creating other translations
 *
 * This file must be loaded after 'fileinput.js'. Patterns in braces '{}', or
 * any HTML markup tags in the messages must not be converted or translated.
 *
 * @see http://github.com/kartik-v/bootstrap-fileinput
 *
 * NOTE: this file must be saved in UTF-8 encoding.
 */
(function ($) {
    "use strict";

    $.fn.fileinput.locales.en = {
        fileSingle: '文件',
        filePlural: '多个文件',
        browseLabel: '浏览  &hellip;',
        removeLabel: '移除',
        removeTitle: '移除所有已选文件',
        cancelLabel: '取消',
        cancelTitle: '停止上传',
        uploadLabel: '上传',
        uploadTitle: '上传所有文件',
        //msgSizeTooLarge: 'File "{name}" (<b>{size} KB</b>) exceeds maximum allowed upload size of <b>{maxSize} KB</b>. Please retry your upload!',
        msgSizeTooLarge: '文件"{name}"(<b>{size} KB</b>)超过最大文件限制<b>{maxSize} KB</b>，请重新选择文件!',
        msgFilesTooLess: 'You must select at least <b>{n}</b> {files} to upload. Please retry your upload!',
        //msgFilesTooMany: 'Number of files selected for upload <b>({n})</b> exceeds maximum allowed limit of <b>{m}</b>. Please retry your upload!',
        msgFileNotFound: '文件 "{name}" 未找到!',
        msgFileSecured: 'Security restrictions prevent reading the file "{name}".',
        msgFileNotReadable: 'File "{name}" is not readable.',
        msgFilePreviewAborted: 'File preview aborted for "{name}".',
        msgFilePreviewError: '读取  "{name}" 文件报错.',
        msgInvalidFileType: '"{name}" 文件格式不正确. 请上传  "{types}" 格式.',
        msgInvalidFileExtension: 'Invalid extension for file "{name}". Only "{extensions}" files are supported.',
        msgValidationError: '无效文件格式',
        msgLoading: 'Loading file {index} of {files} &hellip;',
        msgProgress: 'Loading file {index} of {files} - {name} - {percent}% completed.',
        //msgSelected: '{n} files selected',
        msgSelected: '已选择{n}个文件',
        msgFoldersNotAllowed: 'Drag & drop files only! Skipped {n} dropped folder(s).',
        dropZoneTitle: '拖放文件到这里 &hellip;',
        msgFilesTooMany: '当前上传文件数<b>({n})</b>超过最大上传数量<b>{m}</b>！'
    };

    $.extend($.fn.fileinput.defaults, $.fn.fileinput.locales.en);
})(window.jQuery);