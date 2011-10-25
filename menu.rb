class Menu
  def self.init
    Mode.define(:deck, ".menu") do
      Notes.mode
    end
  end
end

Menu.init   # Define mode




# Below is a different use of the "Menu" class - the "Xiki" menu at the top of emacs





class Menu
  def self.add_menu *name
    menu_spaces = name.join(' ').downcase
    menu_dashes = name.join('-').downcase
    name = name[-1]

    lisp = %Q<
      (define-key global-map
        [menu-bar #{menu_spaces}]
        (cons "#{name}" (make-sparse-keymap "#{menu_dashes}")))
    >
    #puts lisp
    $el.el4r_lisp_eval lisp

    menu = $el.elvar.menu_bar_final_items.to_a
    $el.elvar.menu_bar_final_items = menu.push(name.downcase.to_sym)
  end

  def self.add_item menu, name, function

    menu_spaces = menu.join(' ').downcase
    lisp = "
      (define-key global-map
        [menu-bar #{menu_spaces} #{function}]
        '(\"#{name}\" . #{function}))
    "
    #puts lisp
    $el.el4r_lisp_eval lisp
  end

  def self.init

    add_menu 'Xiki'

    menus = [
      ['Xiki', 'To'],
      ['Xiki', 'Open'],
      ['Xiki', 'Layout'],
      ['Xiki', 'As'],
      ['Xiki', 'Enter'],
      ['Xiki', 'Do'],
      ['Xiki', 'Search']
    ]
    menus.reverse.each do |tuple|
      #       puts "#{tuple[0]}, #{tuple[1]}"
      add_menu tuple[0], tuple[1]
    end
  end

  def self.menu
    "
    - reload) @Launcher.reload_menu_dirs
    "
  end
end
