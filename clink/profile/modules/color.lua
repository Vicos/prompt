local exports = {}

exports.BLACK     = 0
exports.RED       = 1
exports.GREEN     = 2
exports.YELLOW    = 3
exports.BLUE      = 4
exports.MAGENTA   = 5
exports.CYAN      = 6
exports.WHITE     = 7
exports.DEFAULT   = 9
exports.BOLD      = 1
exports.UNDERLINE = 4

exports.set_color = function (fore, back, bold, underline)
    fore = fore or exports.DEFAULT
    back = back or exports.DEFAULT
    bold = bold and exports.BOLD or 22
    underline = underline and exports.UNDERLINE or 24

    return "\x1b["..bold..";3"..fore..";"..underline..";4"..back.."m"
end

exports.color_text = function (text, fore, back, bold, underline)
    return exports.set_color(fore, back, bold, underline)..text..exports.set_color()
end

return exports
