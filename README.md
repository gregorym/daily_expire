# Introduction

DailyExpire is a gem that expire your cache every day or any day of the week.

# Usage

```Erb
<% cache [:deals], :every => :day, :at => '5am' do %>
  <% Deals.today.each do |deal| %>
    <%= render deal %>
  <% end %>
<% end %>
```
