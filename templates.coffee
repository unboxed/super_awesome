module.exports.new_topic = -> """
    <html>
      <body>
        <p id="welcome">Welcome to 'Super Awesome' type in a description of your topic below</p>
        <form method="POST" action="/topic">
          <textarea id="description" name="description"></textarea><br>
          <button type="submit">Make Topic</button>
        </form>
      </body>
    </html>
  """
module.exports.show_topic = (topic, id) -> 
  console.log "called show_topic"
  """
    <html>
      <body>
        <p>#{topic}</p>
        <form method="POST" action="/topic/#{(id + 1)}/choice">
          <input type="text" id="choice" name="choice" placeholder="type choice here"></input>
          <button type="submit">Vote on topic</button>
        </form>
      </body>
    </html>
  """ 
