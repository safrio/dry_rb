Container.register_provider(:db) do |container|
  prepare do
    class RecordNotFoundDbExeption < StandardError; end

    db = {
      accounts: [],
      cat_toys: [],
      characteristics: [],
      orders: [],
      testings: [],
    }

    register('persistance.db', db)
  end

  start do
    # seeds

    container['persistance.db'][:accounts].push(
      id: 1,
      name: 'Sherlock Holmes',
      email: 'sherlock@gmail.com',
      address: '221B Baker Street',
    )

    container['persistance.db'][:cat_toys].push(
      id: 1,
      title: 'fish',
      characteristic: 1,
      archived: false
    )

    container['persistance.db'][:cat_toys].push(
      id: 2,
      title: 'bird',
      characteristic: 1,
      archived: false
    )

    container['persistance.db'][:characteristics].push(
      id: 1,
      testing_id: 1,
      caracteristic_type: 'playful',
      value: 'qweasd12',
      comment: 'too sqare',
      will_recommend: false
    )

    container['persistance.db'][:testings].push(
      id: 1,
      account_id: 1,
      cat_toy_id: 1,
      archived: false
    )

    # ---------------------------------------------------------------------------------------
  end
end
