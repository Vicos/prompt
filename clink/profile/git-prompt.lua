-- Florent's prompt filter
-- Need to use a powerline font to display some character
-- See https://github.com/powerline/fonts

local color = require('color')

function add_segment(segments, text, text_color, bg_color, bold, underline)
  local segment = {
    text=text,
    text_color=text_color,
    bg_color=bg_color,
    bold=bold,
    underline=underline
  }
  table.insert(segments, segment)
end

function format_segments(segments)
  local arrow = ""
  local last_segment = nil
  local out = ""
  for _,segment in pairs(segments) do
    local text = " "..segment['text'].." "
    -- display a > based on color of previous segment and new one
    if last_segment then
      out = out..color.color_text( arrow,
                                   last_segment['bg_color'],
                                   segment['bg_color'],
                                   last_segment['underline'],
                                   segment['underline'] )
    end
    -- display the text
    out = out..color.color_text( text,
                                 segment['text_color'],
                                 segment['bg_color'],
                                 segment['bold'],
                                 segment['underline'] )
    last_segment = segment
  end
  -- display the final >
  if last_segment then
    out = out..color.color_text( arrow,
                                 last_segment['bg_color'],
                                 nil,
                                 last_segment['underline'] )
  end
  return out
end


function florent_prompt_filter()
  local prompt = ""
  local branch = ""
  local prompt_mark = "$"
  -- segments
  local segments = {}
  -- workdir segment
  add_segment( segments, clink.get_cwd(),
               color.DEFAULT, color.BLUE, true, false )
  -- git segment: branch name
  local file = io.popen("git symbolic-ref --short HEAD 2>nul")
  local line = file:read('*line')
  local rc   = file:close()
  if rc then -- display git branch
    add_segment( segments, branch..line,
                 color.BLACK, color.BLUE, false, true )
  end
  -- TODO: add rev count diff with upstream git rev-list --count @{upstream}...
  -- end of segments
  prompt = prompt..format_segments( segments )
  -- $ sign
  prompt = prompt.."\n"..color.color_text( prompt_mark, color.BLACK, nil, true ).." "
  -- push the new prompt
  clink.prompt.value = prompt
  return true -- don't chain with other prompt filter
end

-- clink.prompt.register_filter(florent_prompt_filter, 0)
clink.prompt.register_filter(florent_prompt_filter, 0)
