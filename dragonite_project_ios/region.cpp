#include "region.h"

Region::Region(std::string name_in)
:name{name_in} {}

void Region::add_quest(Quest quest_in) {
    quest_list.push_back(quest_in);
}

Quest *Region::get_quest(int i) {
    return &quest_list[i];
}