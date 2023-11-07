## Libraries
library(tidyverse)
library(lubridate)
library(readxl)
library(here)
capstone_dir <- here('2023', 'Capstone')
capstone_raw_data <- here(capstone_dir, 'raw-data')
capstone_clean_data <- here(capstone_dir, 'clean-data')

### Creating broader categories
personal_services <- c("Men's salons", "Washing, ironing and dry cleaning of various types of clothing, including fur and textiles, including collecting and distributing laundry",
                       "Tailoring, tailoring and tailoring of Arab men’s clothing. Men’s clothing tailoring and tailoring shops", 
                       "Tailoring and tailoring of women's clothing. Women's clothing tailoring stores, such as women's ateliers", 
                       "Women's salons")

food_beverage_services <- c("Restaurants with service", "Fast food activities include pizza shops", "Coffee shops serving beverages", 
                            "Cafeteria buffets", "Retail sale of bakery products and sugary confectionery", 
                            "Retail sale of fresh and preserved fruits and vegetables", "Providing fresh juices and cold drinks", 
                            "Local bread making", "A mobile food truck", "Retail sale of food and beverages in kiosks and markets")

retail_services <- c("Supplies", "Grocery stores", "Pharmacies", "General stores that include a variety of goods", 
                     "Retail sale of new car spare parts and accessories, including car accessories", "Retail sale of women's ready-to-wear clothing", 
                     "Retail sale of cosmetics and decorative soaps", "Retail sale of nuts, coffee, spices and spices", 
                     "Retail sale of automobile and motorcycle fuels at gas stations", "Retail sale of handicrafts, antiques and gifts", 
                     "Retail sale of meat and meat products", "Home furniture retail", "Retail sale of clothing accessories and accessories includes gloves, ties, suspenders, swimming pools and umbrellas", 
                     "Retail sale of ready-made clothing to common stores", "Retail sale of women's abayas and fur items", 
                     "Retail sale of men's ready-to-wear clothing", "Retail sale of blankets, sheets, linens and bedding", 
                     "Retail sale of eye examination equipment. Optical stores", "Retail sale of shoes", "Retail sale of sanitary ware and accessories, such as sinks, chairs, bathtubs, etc., and sauna equipment", 
                     "Retail sale of perfumes", "Retail sale of mobile phones", "Retail sale of poultry and eggs", "Retail sale of marble, natural and artificial stone, ceramic and porcelain", 
                     "Retail sale of flowers and roses", "Retail sale of electronic and electrical household appliances", "Retail sale of textiles and wearable fabrics")

real_estate_construction_services <- c("Real estate management activities in exchange for a commission", "Restorations of residential and non-residential buildings", 
                                       "General construction of residential buildings", "Blacksmith workshops", "Management and leasing of owned or rented residential properties")

automotive_services <- c("Wholesale and retail sale of new car spare parts and accessories, including car accessories", "Installation, maintenance and repair of refrigeration and air conditioning systems", 
                         "Car washing and lubrication", "Maintenance, repair and replacement of light vehicle tires", "Auto electrical repair", 
                         "Automotive mechanical and electrical repair", "Mechanical, electrical, plumbing and car painting repair", 
                         "Automotive machinery repair", "Wholesale and retail sale of vehicle batteries, spark plugs and related accessories")

hospitality_tourism <- c("Hotels", "Activities of tourism and travel agencies", "Furnished residential units")

professional_technical_services <- c("Integrated office administrative services activities", "Engineering and architectural consulting activities")

wholesale_trade <- c("Wholesale of electronic and electrical household appliances", "Wholesale of men's clothing", "Wholesale of wires, electrical switches and wiring equipment")



# Retail services vector
retail_services2 <- c("Retail sale of textiles and wearable fabrics",
                     "Retail sale of tobacco products in specialized stores and sale of molasses and jarak",
                     "Retail sale of various household items and handicrafts, cutting tools, ceramics, glassware, pottery, etc",
                     "Retail sale of sportswear",
                     "Retail sale of trekking and fishing supplies",
                     "Retail sale of stationery, office supplies, newspapers and magazines",
                     "Retail sale of electrical tools and extensions",
                     "Retail sale of mobile phone accessories",
                     "Retail sale of games and toys in specialized stores",
                     "Retail sale of building materials includes cement blocks, gypsum, cement tiles etc",
                     "Retail sale and installation of hotel, restaurant, kitchen and automatic laundry equipment",
                     "Retail sale of fish and other seafood and their products",
                     "Retail sale of watches of all kinds",
                     "Retail sale of chandeliers, chandeliers, goods used in lighting and their accessories",
                     "Retail sale of children's clothing",
                     "Retail sale of scrap metal, carpentry and blacksmithing tools and tools",
                     "Retail sale of carpets and rugs",
                     "Retail sale of oud and incense",
                     "Retail sale of textiles, clothing and shoes in kiosks and markets",
                     "Retail sale of bags",
                     "Retail sale of decorative products, industrial ceilings, insulating materials and building materials",
                     "Retail sale of pets, pet foods, ornamental fish and supplies",
                     "Retail trade and maintenance of construction machinery and equipment, petroleum civil engineering, heavy equipment")

# Wholesale trade vector
wholesale_trade2 <- c("Wholesale of home furniture and furniture",
                     "Wholesale of food and beverages",
                     "Wholesale sale of used spare parts and their end-of-life after dismantling them to obtain usable spare parts and benefit from selling them for cars",
                     "Wholesale and retail sale of used private cars includes ambulances, minibuses and four-wheel drive cars",
                     "Wholesale of clothing accessories such as gloves, neckties, suspenders, and swimwear",
                     "Wholesale and retail sale of car tires and accessories",
                     "Wholesale of gifts and luxuries",
                     "Wholesale and retail sale of new private cars includes ambulances, minibuses and four-wheel drive vehicles",
                     "Wholesale of dates",
                     "Wholesale of all kinds of bottled water",
                     "Wholesale of men's fabrics")

# Automotive services vector
automotive_services2 <- c("Consumer electronics repair",
                         "Installation of doors, windows, door frames, porches, balustrades, stairs, and wooden kitchens",
                         "Car seat repair",
                         "Car body shops, including rust treatment",
                         "Polish car polishing",
                         "Activities of car service and maintenance centers")

# Hospitality and tourism vector
hospitality_tourism2 <- c("Renting event supplies, event tents, wedding booths, etc",
                         "Ice cream shops",
                         "Hajj and Umrah catering providers",
                         "Fish and seafood grill shops",
                         "Roaming ice cream van")

# Professional and technical services vector
professional_technical_services2 <- c("Interior design activities",
                                     "Photography activities",
                                     "Building maintenance services activities",
                                     "Main office activities",
                                     "Activities of calligraphers and painters",
                                     "Design and programming special software",
                                     "Providing marketing services on behalf of others",
                                     "Law firm and legal consulting activities",
                                     "Activities of reselling telecommunications services distributors",
                                     "Training centers",
                                     "General medical complexes",
                                     "Sale of veterinary medicines includes veterinary equipment")

# Real estate and construction services vector
real_estate_construction_services2 <- c("Land transportation of goods",
                                       "Transport of goods and heavy transport equipment",
                                       "Building finishing",
                                       "General construction of non-residential buildings such as schools, hospitals, hotels etc",
                                       "Construction equipment rental with operator",
                                       "Painting and coating works for interior and exterior buildings")

# Food and beverage services vector
food_beverage_services2 <- c("Kitchens for preparing banquets and parties",
                            "Dry food stores")

# Personal services vector
personal_services2 <- c("Men's gyms and sports centres",
                       "Private children’s hospitality centres",
                       "Copying and photocopying activities",
                       "Providing payment services for points of sale, safe and smart electronic outlets, and automated deposit teller machines",
                       "Primary education for students with a national curriculum",
                       "Metal turning",
                       "Motorized equipment rental",
                       "Carpentry workshops in general",
                       "Selling tools and plastic materials, including bags")

# R vectors for each category based on the provided list

# Retail services related vectors
retail_services3 <- c("Retail sale of textiles and wearable fabrics", "Retail sale of tobacco products in specialized stores and sale of molasses and jarak",
                     "Consumer electronics repair", "Retail sale of various household items and handicrafts, cutting tools, ceramics, glassware, pottery, etc",
                     "Retail sale of sportswear", "Retail sale of trekking and fishing supplies", "Retail sale of stationery, office supplies, newspapers and magazines",
                     "Retail sale of electrical tools and extensions", "Repair of household appliances, home and garden equipment", 
                     "Retail sale of mobile phone accessories", "Retail sale of building materials includes cement blocks, gypsum, cement tiles etc", 
                     "Retail sale and installation of hotel, restaurant, kitchen and automatic laundry equipment", 
                     "Retail sale of games and toys in specialized stores", "Ice cream shops", "Retail sale of scrap metal, carpentry and blacksmithing tools and tools", 
                     "Retail sale of carpets and rugs", "Retail sale of oud and incense", "Retail trade and maintenance of construction machinery and equipment, petroleum civil engineering, heavy equipment",
                     "Retail sale of textiles, clothing and shoes in kiosks and markets", "Retail sale of bags", 
                     "Retail sale of fish and other seafood and their products", "Retail sale of watches of all kinds", "Retail sale of chandeliers, chandeliers, goods used in lighting and their accessories",
                     "Retail sale of children's clothing", "Retail sale of computers and accessories including printers and their inks", "Retail sale of medical devices, equipment and supplies", 
                     "Retail sale of fuel gas cylinders", "Retail sale of chocolate and cocoa", "Retail sale of dates", "Retail sale of camping equipment", 
                     "Retail sale of agricultural machinery and equipment", "Retail sale of home appliances", "Retail sale of pigments, paints, varnishes and adhesives", 
                     "Retail sale of special and health food trade", "Retail sale of spare parts for industrial equipment and machinery", "Retail sale of live livestock, sheep and camels", 
                     "Retail sale of glass sheets", "Retail sale of water purification devices, equipment and supplies", "Retail sale of uniforms", 
                     "Retail sale of sewing and knitting supplies", 'Central markets for food and consumer goods')

# Wholesale and trade related vectors
wholesale_trade3 <- c("Wholesale of home furniture and furniture", "Wholesale of food and beverages", 
                     "Wholesale sale of used spare parts and their end-of-life after dismantling them to obtain usable spare parts and benefit from selling them for cars",
                     "Wholesale and retail sale of used private cars includes ambulances, minibuses and four-wheel drive cars", 
                     "Wholesale of clothing accessories such as gloves, neckties, suspenders, and swimwear", "Wholesale of dates", 
                     "Wholesale of office supplies and stationery", "Wholesale of telephones and communication equipment", "Wholesale of metal industrial roofs, doors, windows and metal products",
                     "Wholesale of computers and their accessories includes the sale of printers and their inks", "Wholesale of household utensils and table accessories", 
                     "Wholesale of wooden, cork and plastic products", "Wholesale of carpets and rugs", "Wholesale of women's clothing", "Wholesale of soaps and detergents", 
                     "Wholesale of bakery products", "Wholesale of children's toys", "Wholesale of women's fabrics")

# Real estate and construction related vectors
real_estate_construction_services3 <- c("Installation of doors, windows, door frames, porches, balustrades, stairs, and wooden kitchens", "Land transportation of goods", 
                                       "Interior design activities", "Building maintenance services activities", "Construction equipment rental with operator", 
                                       "Painting and coating works for interior and exterior buildings", "Building finishing", "General construction of non-residential buildings such as schools, hospitals, hotels etc",
                                       "Installation of aluminum doors, windows, door frames, balustrades, stairs, and kitchens", "Buying and selling land and real estate, dividing it, and off-plan sales activities", 
                                       "Installation and maintenance of fire alarm devices and equipment", "Installation of doors, windows, door frames, porches, balustrades, stairs, and metal kitchens")

# Automotive services related vectors
automotive_services3 <- c("Repair of household appliances, home and garden equipment", "Wholesale and retail sale of car tires and accessories", 
                         "Car seat repair", "Car body shops, including rust treatment", "Activities of car service and maintenance centers", "Car axles and brakes repair", 
                         "Car glass repair and installation", "Installing thermal insulation for car windows", "Car exhaust repair", "Car electronics repair")

# Food and beverage services related vectors
food_beverage_services3 <- c("Ice cream shops", "Kitchens for preparing banquets and parties", "Manufacture of bread and its products using automated bakeries", 
                            "Retail sale of chocolate and cocoa", "Retail sale of dates", "Activities of caterers who provide food services", 
                            "Manufacture of popular food bread and raw pastry sheets, including matai", "Special and health food trade", 
                            "Dry food stores", "Fish and seafood grill shops", "Manufacture of various types of popular and oriental sweets", 
                            "Preparing and processing sweets")

# Personal and other services related vectors
personal_services3 <- c("Renting event supplies, event tents, wedding booths, etc", "Photography activities", "Repair of household appliances, home and garden equipment", 
                       "Building maintenance services activities", "Training centers", "Providing marketing services on behalf of others", 
                       "Activities of calligraphers and painters", "Law firm and legal consulting activities", "Men's gyms and sports centres", 
                       "Private children’s hospitality centres", "Main office activities", "Copying and photocopying activities", "Providing payment services for points of sale, safe and smart electronic outlets, and automated deposit teller machines", 
                       "General medical complexes", "Sale of veterinary medicines includes veterinary equipment", "Roaming ice cream van", "Transaction tracking activities", 
                       "Public service activities", "Passenger car rental without a driver")

## New (FOURTH ROUND)
personal_services4 <- c("Blacksmith workshops", "Medical clinics", "Sports clubs", "Bicycle repair", 
                       "Lock making and key making", "Children's salons", "Women's gyms and sports centres", 
                       "Amusement parks")

food_beverage_services4 <- c("Central markets for food and consumer goods", "Refrigerated food stores", 
                            "Cutting, packing and wrapping fruits and vegetables", "Retail sale of beverages in specialized stores", 
                            "Retail sale of honey")

retail_services4 <- c("Passenger car rental without a driver", "Retail sale of precious metals and gemstones", 
                     "Trip supplies rental", "Retail sale of non-wearable types of textiles and fabrics, such as curtains", 
                     "Retail sale of used home furniture", "Tailoring and sewing work uniforms", 
                     "Local parcel transportation", "Retail sale of spare parts for air conditioning and refrigeration equipment", 
                     "Sales agents in food and beverages", "The retail sale of building materials scrap includes the trade in scrap iron", 
                     "Retail sale of cleaning supplies", "Retail sale of tents", "Selling luxuries and selling daggers and silverware", 
                     "Wholesale and retail sale of spare parts for trucks and heavy transport", "Wholesale of children's clothing", 
                     "Wholesale of watches", "Retail sale of agricultural seedlings and nursery plants", 
                     "Retail sale of honey", "Sales agents in cosmetics", "Wholesale of precious metals and gemstones")

real_estate_construction_services4 <- c("Various decoration works and installation", "General construction of government buildings", 
                                       "Installation and extension of computer and communications networks", 
                                       "Installation and maintenance of elevators", "Real estate valuation", 
                                       "Installation and maintenance of security devices", "Construction of roads, streets, sidewalks and road supplies")

automotive_services4 <- c("Change oils", "Wholesale sale of used spare parts and their end-of-life after dismantling them to obtain usable spare parts and benefit from selling them for cars", 
                         "Auto scale", "Wholesale and retail sale of used car spare parts and accessories")

hospitality_tourism4 <- c("Providing services for Umrah pilgrims and visitors to the Prophet’s Mosque coming from outside the Kingdom", 
                         "Organizing weddings and special events")

professional_technical_services4 <- c("Mediating in the recruitment of expatriate workers", "Advertising institutions and agencies", 
                                     "Installing, maintaining and repairing sanitary ware", "Repair and maintenance of personal computers and laptops of all types", 
                                     "Repair and maintain cooling and air purification devices such as refrigerators, freezers, and air conditioners, regardless of their size", 
                                     "Repair and maintenance of mobile phones", "Repair, restoration and installation of home furnishings, including office furniture", 
                                     "Commercial breaks", "Repair and maintenance of engines, electric generators and steam generating devices", 
                                     "Parcel and gift wrapping activities", "Local national commercial banks", "Packing and grinding wheat", 
                                     "Furniture upholstery", "Providing fixed telecommunications services", "Manufacturing and detailing of Arab councils", 
                                     "Authorized air freight agencies", "Extension of electrical wires", "Cutting and detailing of tents and sails", 
                                     "Engineering and technical activities related to the specialized activities of all branches of engineering", 
                                     "Radiator repair", "Grain mills", "Organizing and managing exhibitions and conferences", 
                                     "Review and audit activities", "Furniture installation", "Medical Laboratory", 
                                     "Medicine warehouse activities", "Manufacture of furniture and furniture from wood", 
                                     "Manufacture of precious metals and gemstones", "Providing senior management consulting services", 
                                     "Specialized medical complexes", "Selling and installing machinery and factory equipment", 
                                     "Wholesale of metal and iron strips, extrusions and blocks", "Wholesale of spare parts for industrial equipment and machinery", 
                                     "Activities of shipping and shipping agencies", "printing")

wholesale_trade4 <- c("Aluminum manufacturing workshops", "Plastics industry in its primary forms", 
                     "Wholesale of ready-made clothes", "Cutting and tailoring of curtains", 
                     "Storage in grain and flour silo warehouses, food and agricultural products stores", 
                     "Wholesale of vegetables", "Wholesale of chocolate and cocoa")

### FIFTH ROUND
personal_services5 <- c("Physiotherapy centres", "Palaces and halls for weddings and events with accommodation", 
                       "General cleaning of buildings", "Care and maintenance of building landscapes, home gardens, 
                       roof gardens, facades of private buildings, etc", "Washing rugs, carpets, curtains, etc., whether 
                       they are washed at the customer’s place or elsewhere", "Complementary and alternative medicine complexes", 
                       "Dental laboratories and prosthetics", "Hospitals")

food_beverage_services5 <- c("Production and bottling of pure, filtered water", "Popular cafes")

retail_services5 <- c("Furniture and lumber stores", "Retail sale of elevators, escalators and conveyor belts", 
                     "Wholesale and retail sale of used heavy transport vehicles, trailers and semi-lorries", 
                     "Retail sale of oils and lubricants", "Retail sale of video games, software and accessories", 
                     "Retail trade of safety, fire and industrial security equipment includes filling fire extinguishers without 
                     carrying out conversion operations", "Selling and installing beauty shop equipment and tools", 
                     "Serviced apartments", "Retail sale of dairy products, eggs, olives and pickles", 
                     "Retail sale of prepaid cards of all kinds", "Water pumping equipment for sale", 
                     "Retail sale of wood, cork and plastic products", "Selling solar energy devices and equipment")

real_estate_construction_services5 <- c("Installing, extending, maintaining and repairing air conditioning ducts", 
                                       "Scaffolding installation works", "Prefabricated building construction on sites", 
                                       "Installing interior ceilings and partitions and covering the walls with wood", 
                                       "Production of ready-mixed concrete")

automotive_services5 <- c("Automotive hydraulic repair", "Repair and maintenance of motorcycles and the like", 
                         "Car air conditioner repair")

hospitality_tourism5 <- c("Bicycle rental and rental", "Renting equipment for comfort and pleasure that complements the recreation facilities", 
                         "Management of tourist accommodation facilities", "Organizing tourist trips")

professional_technical_services5 <- c("Manufacture of types of gypsum, including frames, engraved frames, statues, vases, and other decorative items", 
                                     "Veterinary clinic activities", "Installation, repair and maintenance of automatic doors", 
                                     "Reducing water salinity", "Specialized transportation", "Customs clearance activities", 
                                     "Extension of oil and gas pipelines", "General fare", "Repair and maintain printers and scanners", 
                                     "Installing glass and mirrors for buildings", "Installing, maintaining and repairing solar energy networks", 
                                     "Language and conversation skills institutes", "Permanent exhibitions of factory products", 
                                     "Management consulting activities")

wholesale_trade5 <- c("Wholesale of agricultural equipment and machinery spare parts", "Wholesale of pharmaceutical goods", "Wholesale of shoes", 
                     "Wholesale of domestic animal food and feed", "Wholesale of fruits", "Wholesale of generators and electrical transformers", 
                     "Wholesale of honey", "Wholesale of cosmetics and soaps", "Wholesale of solid fuels, including coal, coal, wood and naphtha", 
                     "Wholesale of tools and hand tools such as screwdrivers, saws, hammers, etc", "Auto parts turning activities", 
                     "Customizing mattress pads of various types", "Wholesale of coffee and tea products", "Wholesale of frozen meat and poultry", 
                     "Wholesale of mobile phone accessories", "re Insurance", "Wholesale of blankets, ready-made linens and sheets", 
                     "Wholesale of chandeliers and lighting items")


## SIXTH ROUND
# Assigning provided list items to their respective R vectors based on service category

# personal_services
personal_services6 <- c("Pre-school and kindergarten education with a national curriculum",
                       "Cow breeding",
                       "Cultivation of ornamental plants and nursery seedlings",
                       "Home medical services centers",
                       "Primary education for female students using a national curriculum",
                       "Tailoring, tailoring and weaving of non-Arab men's clothing")

# food_beverage_services
food_beverage_services6 <- c("Distribution centers for food and beverages",
                            "Wholesale of carbonated water and juices")

# retail_services
retail_services6 <- c("Light vehicle sales agents on commission",
                     "Medical device and product stores",
                     "Retail trade of safety, fire and industrial security equipment includes filling fire extinguishers without carrying out conversion operations",
                     "Entertainment centers",
                     "Washing rugs, carpets, curtains, etc., whether they are washed at the customer’s place or elsewhere",
                     "Retail sale of agricultural equipment and machinery spare parts",
                     "Retail sale of books, magazines, newspapers and educational aids",
                     "Retail sale of cassette, video and DVD records of all kinds",
                     "Retail sale of ready-made curtains and mosquito nets",
                     "Retail sale of sports equipment, hunting, bicycles, etc",
                     "Selling and installing artificial grass",
                     "Retail sale of security devices",
                     "Selling artificial ornaments",
                     "Wholesale sale of women's abayas")

# real_estate_construction_services
real_estate_construction_services6 <- c("Care and maintenance of building landscapes, home gardens, roof gardens, facades of private buildings, etc",
                                       "Cutting and rinsing regular glass",
                                       "Installing and maintaining key manufacturing and duplicating machines",
                                       "Maintenance, repair and replacement of heavy vehicle tires",
                                       "Manufacture of refractory bricks, blocks and tiles, including refractory cement",
                                       "Manufacture of sanitary ware from plastics, including wash basins, showers, and toilets",
                                       "Operate warehousing facilities for all types of goods",
                                       "Operations carried out on rough stones outside quarries, such as sawing, polishing and grinding",
                                       "Private civil security guard",
                                       "Selling and installing beauty shop equipment and tools",
                                       "Wooden decoration works",
                                       "Installation, repair and maintenance of thermal and water insulation systems",
                                       "Management and leasing of owned or rented non-residential properties",
                                       "Paints industry",
                                       "Wholesale of bricks, tiles, stone, marble, ceramic and porcelain",
                                       "Wholesale of office furniture")

# automotive_services
automotive_services6 <- c("Wholesale sale of used spare parts and their end-of-life after dismantling them to obtain usable spare parts and benefit from selling them for cars.",
                         "Installation and maintenance of firefighting devices and equipment",
                         "Maintenance, repair and replacement of heavy vehicle tires",
                         "Wholesale and retail sale of motorcycles and small steam engines")

# hospitality_tourism
hospitality_tourism6 <- c("Tourist lodges")

# professional_technical_services
professional_technical_services6 <- c("Activities of brokers' agents, auctioneers' offices",
                                     "Freight brokers",
                                     "Closely or remotely monitor electronic alarm systems, such as theft or fire alarm systems, including their maintenance",
                                     "Export and import activities",
                                     "Export activities",
                                     "Extending pipes of various types for electricity, communications, etc",
                                     "Market research and opinion polls",
                                     "Publishing paper books, dictionaries, atlases, and maps, which includes: importing and producing written, drawn, or photographed intellectual materials.",
                                     "Prepress services activities",
                                     "Surveying and quantitative services activities", 'Logistics services', 'Import activities')

# wholesale_trade
wholesale_trade6 <- c("Military clothing industry",
                     "Wholesale of chemicals",
                     "Wholesale of medical devices, equipment and supplies",
                     "Wholesale of metal accessories, locks, hinges, etc",
                     "Manufacture of men's clothing",
                     "Local and international parcel transportation",
                     "Repair and maintenance of machinery for mining, construction, and oil and gas fields")




### Final version
personal_services <- c(personal_services, personal_services2, personal_services3, personal_services4, personal_services5, personal_services6)
food_beverage_services <- c(food_beverage_services, food_beverage_services2, food_beverage_services3, food_beverage_services4, food_beverage_services5, food_beverage_services6)
retail_services <- c(retail_services, retail_services2, retail_services3, retail_services4, retail_services5, retail_services6)
real_estate_construction_services <- c(real_estate_construction_services, real_estate_construction_services2, real_estate_construction_services3, real_estate_construction_services4, real_estate_construction_services5, real_estate_construction_services6)
automotive_services <- c(automotive_services, automotive_services2, automotive_services3, automotive_services4, automotive_services5, automotive_services6)
hospitality_tourism <- c(hospitality_tourism, hospitality_tourism2, hospitality_tourism4, hospitality_tourism5, hospitality_tourism6)
professional_technical_services <- c(professional_technical_services, professional_technical_services2, professional_technical_services4, professional_technical_services5, professional_technical_services6)
wholesale_trade <- c(wholesale_trade, wholesale_trade2, wholesale_trade3, wholesale_trade4, wholesale_trade5, wholesale_trade6)

## Creating the final dataset
lookup_category <- tibble(broad_category = c(rep('Personal Services', times = length(personal_services)),
                                                rep('Food and Beverage Services', times = length(food_beverage_services)),
                                                rep('Retail Services', times = length(retail_services)),
                                                rep('Real Estate and Construction Services', times = length(real_estate_construction_services)),
                                                rep('Automative Services', times = length(automotive_services)),
                                                rep('Hospitality and Tourism', times = length(hospitality_tourism)),
                                                rep('Professional and Technical Services', times = length(professional_technical_services)),
                                                rep( 'Wholesale Trade', times = length(wholesale_trade))),
                              category_EN = c(personal_services,
                                               food_beverage_services,
                                               retail_services,
                                               real_estate_construction_services,
                                               automotive_services,
                                               hospitality_tourism,
                                               professional_technical_services,
                                               wholesale_trade)
                              )

## Final touches
commercial_licenses <- read_csv(here(capstone_clean_data, '3-commercial_licenses_cleaned.csv')) %>% 
  ## Keeping only EN columns and orderering the time period
  select(c(1), contains(c('EN', 'date', 'code'))) %>% 
  select(1,10,2,11,3,13,5,12,4,6,7,8,9) %>% 
  filter(date_of_the_request == '2022-1')

per_category <- commercial_licenses %>%
  select(id, municipality_code, municipality_EN,
         category_code, category_EN, subcategory_code, subcategory_EN) %>% 
  group_by(category_EN, municipality_EN) %>% 
  summarize(total_business = n_distinct(id)) %>% 
  arrange(category_EN, desc(total_business)) %>% 
  slice(1) %>% 
  ungroup()

per_category_complete <- per_category %>% 
  left_join(lookup_category, by = 'category_EN') %>% 
  arrange(desc(total_business)) %>% 
  mutate(broad_category = case_when(is.na(broad_category) & str_detect(category_EN, pattern = 'Wholesale') ~ 'Wholesale Trade',
                                    is.na(broad_category) & str_detect(category_EN, pattern = 'Construction') ~ 'Real Estate and Construction Services',
                                    is.na(broad_category) & str_detect(category_EN, pattern = 'Installation') ~ 'Professional and Technical Services',
                                    is.na(broad_category) & str_detect(category_EN, pattern = 'Repair') ~ 'Professional and Technical Services',
                                    is.na(broad_category) & str_detect(category_EN, pattern = 'Retail') ~ 'Retail Services',
                                    TRUE ~ broad_category
  ))

# Final format
per_category_complete_final <- per_category_complete %>% 
  filter(!is.na(category_EN)) %>% 
  select(-municipality_EN, -total_business) %>% 
  select(broad_category, category_EN) %>% 
  arrange(broad_category, category_EN) %>%
  group_by(category_EN) %>% 
  slice(1)


# Saving the file
write_csv(per_category_complete_final, here(capstone_clean_data, 'lookup_broad_category.csv'))
