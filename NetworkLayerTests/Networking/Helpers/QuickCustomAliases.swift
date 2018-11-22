//
//  QuickCustomAliases.swift
//  NetworkLayerTests
//
//  Created by Marcin Jackowski on 24/10/2018.
//  Copyright © 2018 CocoApps. All rights reserved.
//

import Quick

func given(_ description: String, closure: @escaping () -> ()) {
    describe(description, closure)
}

func when(_ description: String, closure: @escaping () -> ()) {
    context(description, closure)
}

func then(_ description: String, closure: @escaping () -> ()) {
    it(description, closure: closure)
}

func onlyThen(_ description: String, closure: @escaping () -> ()) {
    fit(description, closure: closure)
}
