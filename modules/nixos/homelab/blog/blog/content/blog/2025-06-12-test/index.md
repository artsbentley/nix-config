+++
title = "HAHAHAHAHAH"
date = 2025-05-18
+++

with the following HTML we want to sync the `delay` and `amount` signals so the
backend

```html
<body class="bg-base-100 text-lg max-w-xl mx-auto my-16">
  <div
    data-signals="{delay:400, amount:1}"
    class="bg-base-100 text-base-content rounded-lg px-6 py-8 shadow-xl space-y-2"
  >
    <p class="mt-2">
      SSE events will be streamed from the backend to the frontend.
    </p>
    <div class="space-x-2">
      <label for="amount">amount of times </label>
      <input
        data-bind-amount
        id="amount"
        type="number"
        step="1"
        min="0"
        class="input input-bordered w-36"
      />
    </div>
    <div class="space-x-2">
      <label for="delay">Delay in milliseconds </label>
      <input
        data-bind-delay
        id="delay"
        type="number"
        step="100"
        min="0"
        class="input input-bordered w-36"
      />
    </div>
    <button data-on-click="@get('/hello-world')" class="btn btn-primary">
      Start
    </button>
  </div>
  <div
    class="my-16 text-8xl font-bold"
    style="background: linear-gradient(to right in oklch, red, orange, yellow, green, blue, blue, violet); background-clip: text; -webkit-background-clip: text; color: transparent;"
  >
    <div id="message">Hello, world!</div>
  </div>
</body>
```

```go
type Store struct {
	Delay  time.Duration `json:"delay"`
	Amount int           `json:"amount"`
}

r.Get("/hello-world", func(w http.ResponseWriter, r *http.Request) {
	store := &Store{}
	if err := datastar.ReadSignals(r, store); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	sse := datastar.NewSSE(w, r)

	var b strings.Builder
	b.WriteString(strings.Repeat("message ", store.Amount))
	message := b.String()
	sse.MergeFragments(`<div id="message">` + message + `</div>`)
})
```
