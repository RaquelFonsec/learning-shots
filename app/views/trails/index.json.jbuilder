json.array! @results do |result|
  json.html render partial: 'trails/video', locals: { video: result }
end
