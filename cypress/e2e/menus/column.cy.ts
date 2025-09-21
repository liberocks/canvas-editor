import Editor from '../../../src/editor'

describe('菜单-分栏', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/canvas-editor/')
    cy.get('canvas').first().as('canvas').should('have.length', 1)
  })

  it('插入双栏分节', () => {
    cy.getEditor().then((editor: Editor) => {
      editor.command.executeSelectAll()
      editor.command.executeBackspace()

      cy.get('.menu-item__column').click()
      cy.get('.menu-item__column .options li[data-columns="2"]').click()

      const data = editor.command.getValue().data.main
      const hasSectionBreak = data.some((el: any) => el.type === 'sectionBreak')
      expect(hasSectionBreak).to.eq(true)
    })
  })
})
