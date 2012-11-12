# Introduction

DailyExpire is a gem that expire your cache every day or any day of the week.

# Usage

Let says you run a daily deal website and you want to expire your cache every morning at 5am.

```Erb
<% cache [:deals], :every => :day, :at => '5am' do %>
  <% Deals.today.each do |deal| %>
    <%= render deal %>
  <% end %>
<% end %>
```